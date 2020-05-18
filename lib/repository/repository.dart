import 'dart:async';

import '../models/global.dart';
import '../models/serbia.dart';
import '../http/corona_api.dart';
import './cache.dart';

class CoronaRepository {
  final CoronaApi _coronaApi = CoronaApi();
  final CacheManager _cacheManager = CacheManager();

  Future<Global> getGlobal({bool newCall}) async {
    Global global = _cacheManager.global;
    if (global == null || newCall) {
      global = await _coronaApi.getGlobal();
      if (global != null) {
        _cacheManager.global = global;
      }
    }
    return Future.value(global);
  }

  Future<Serbia> getSerbia({bool newCall}) async {
    Serbia serbia = _cacheManager.serbia;
    if (serbia == null || newCall) {
      serbia = await _coronaApi.getSerbia();
      if (Serbia != null) {
        _cacheManager.serbia = serbia;
      }
    }
    return Future.value(serbia);
  }
}
