export 'platform_base.dart'
  if (dart.library.io) 'platform_native.dart'
  if (dart.library.html) 'platform_web.dart';