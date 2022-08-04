import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:starfish_annotations/starfish_annotations.dart';

import 'model_visitor.dart';

class SubclassGenerator extends GeneratorForAnnotation<StarfishGen> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();

    generateExtension(visitor, classBuffer);
    generateCreateDelta(visitor, classBuffer);
    generateUpdateDelta(visitor, classBuffer);

    return classBuffer.toString();
  }

  void generateExtension(ModelVisitor visitor, StringBuffer classBuffer) {
    final extensionName = '${visitor.className}HiveApi';

    classBuffer.writeln('extension $extensionName on ${visitor.className} {');

    for (final field in visitor.constructorParameters) {
      if (field.isRequired) {
        classBuffer.write('required ');
      }
      classBuffer.write('this.${field.name}');
      if (field.hasDefaultValue) {
        classBuffer.write(' = ${field.defaultValueCode}');
      }
      classBuffer.writeln(',');
    }

    classBuffer.writeln('});');

    for (final field in visitor.constructorParameters) {
      classBuffer.writeln(
          'final ${field.type.getDisplayString(withNullability: false)} ${field.name};');
    }

    classBuffer.writeln('}');
  }

  void generateCreateDelta(ModelVisitor visitor, StringBuffer classBuffer) {
    final className = '${visitor.className}CreateDelta';

    classBuffer.writeln('class $className {');

    classBuffer.writeln('$className({');

    for (final field in visitor.constructorParameters) {
      if (field.isRequired) {
        classBuffer.write('required ');
      }
      classBuffer.write('this.${field.name}');
      if (field.hasDefaultValue) {
        classBuffer.write(' = ${field.defaultValueCode}');
      }
      classBuffer.writeln(',');
    }

    classBuffer.writeln('});');

    for (final field in visitor.constructorParameters) {
      classBuffer.writeln(
          'final ${field.type.getDisplayString(withNullability: false)} ${field.name};');
    }

    classBuffer.writeln('}');
  }

  void generateUpdateDelta(ModelVisitor visitor, StringBuffer classBuffer) {
    final className = '${visitor.className}UpdateDelta';

    classBuffer.writeln('class $className {');

    classBuffer.writeln('$className({');
    classBuffer.writeln('required this.originalModel,');

    final settableFields =
        visitor.classFields.where((item) => item.setter != null).toList();

    for (final field in settableFields) {
      classBuffer.writeln('this.${field.name},');
    }

    classBuffer.writeln('});');

    classBuffer.writeln('final ${visitor.className} originalModel;');

    for (final field in settableFields) {
      classBuffer.writeln(
          'final ${field.type.getDisplayString(withNullability: false)}? ${field.name};');
    }

    classBuffer.writeln('bool apply() {');
    classBuffer.writeln('var somethingUpdated = false;');

    for (final field in settableFields) {
      final name = field.name;
      classBuffer.writeln('''
      if ($name != null && $name != originalModel.$name) {
        somethingUpdated = true;
        originalModel.$name = $name!;
      }
      ''');
    }

    classBuffer.writeln('''
      if (somethingUpdated) {
        // TODO: save the model.
      }
      return somethingUpdated;
      ''');

    classBuffer.writeln('}');

    classBuffer.writeln('}');
  }
}
