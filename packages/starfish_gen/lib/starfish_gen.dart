import 'package:build/build.dart';
import 'src/subclass_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder getBuilder(BuilderOptions options) =>
    SharedPartBuilder([SubclassGenerator()], 'starfish_gen');
