import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:starfish_annotations/starfish_annotations.dart';

extension IsAnnotated on List<ElementAnnotation> {
  bool hasAnnotation<T>() =>
      any((annotation) => annotation.computeConstantValue().runtimeType == T);
}

class ModelVisitor extends SimpleElementVisitor<void> {
  List<ParameterElement> constructorParameters = [];
  final List<FieldElement> classFields = [];
  late String className;
  // final fields = <String, dynamic>{};

  List<FieldElement> get primaryFields => classFields
      .where((field) => field.metadata.hasAnnotation<Primary>())
      .toList();

  @override
  void visitClassElement(ClassElement element) {
    className = element.name;
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    if (element.name.isEmpty) {
      className = element.enclosingElement.name;
      constructorParameters = element.parameters;
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isPublic) {
      classFields.add(element);
    }
  }
}
