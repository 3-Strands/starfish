import 'dart:io';

String root() {
  final currentScript = Platform.script;
  final path = currentScript.path;
  return path.substring(
      0, path.length - 6 - currentScript.pathSegments.last.length);
}

void goToRoot() {
  Directory.current = root();
}
