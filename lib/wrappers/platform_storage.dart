export 'platform_storage_base.dart'
  if (dart.library.html) 'platform_storage_web.dart'
  if (dart.library.io) 'platform_storage_native.dart';