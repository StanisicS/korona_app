import '../models/global.dart';
import '../models/serbia.dart';

class CacheManager {
  static final CacheManager _cacheManager = CacheManager._internal();

  factory CacheManager() => _cacheManager;

  CacheManager._internal();

  Global global;
  Serbia serbia;
}
