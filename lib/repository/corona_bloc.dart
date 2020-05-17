import 'dart:async';

import '../models/global.dart';
import '../models/serbia.dart';

import './cache.dart';
import './repository.dart';
import '../util/logging.dart';
import 'package:rxdart/rxdart.dart';

class CoronaBloc {
  static final CoronaBloc _instance = CoronaBloc._internal();

  factory CoronaBloc() => _instance;

  CoronaBloc._internal() {
    _init();
  }

  final CoronaRepository _coronaRepository = CoronaRepository();
  final _StateManager _stateManager = _StateManager();
  final CacheManager _cacheManager = CacheManager();

  void _init() {
    getGlobal(newCall: true);
    getSerbia(newCall: true);
  }

  Future<void> getGlobal({bool newCall}) async {
    final Global global = await _coronaRepository.getGlobal(newCall: newCall);
    if (global != null) {
      CoronaBloc().globalBehaviorSubject$.add(global);
    }
  }

  Future<void> getSerbia({bool newCall}) async {
    final List<Serbia> serbia =
        await _coronaRepository.getSerbia(newCall: newCall);
    if (serbia != null) {
      CoronaBloc().serbiaBehaviorSubject$.add(serbia);
    }
  }

  void dispose() {
    _stateManager.dispose();
  }

  Global get global$ => _cacheManager.global;

  List<Serbia> get serbia$ => _cacheManager.serbia;

  BehaviorSubject<Global> get globalBehaviorSubject$ =>
      _stateManager.globalBehaviorSubject;

  BehaviorSubject<List<Serbia>> get serbiaBehaviorSubject$ =>
      _stateManager.serbiaBehaviorSubject;
}

class _StateManager {
  BehaviorSubject<Global> globalBehaviorSubject = BehaviorSubject();
  BehaviorSubject<List<Serbia>> serbiaBehaviorSubject = BehaviorSubject();

  void dispose() {
    logger.info("dispose _StateManager streams");
    globalBehaviorSubject.close();
    serbiaBehaviorSubject.close();
  }
}
