export 'file_system_base.dart'
  if (dart.library.io) 'file_system_native.dart'
  if (dart.library.html) 'file_system_web.dart';
