import 'dart:async';
import 'dart:convert';
import 'dart:io' show HttpStatus;

import './api_config.dart';
import '../models/global.dart';
import '../models/serbia.dart';

import '../repository/corona_bloc.dart';
import '../utils/logging.dart';
import 'package:http/http.dart' as http;

class CoronaApi {
  Future<Global> getGlobal() async {
    try {
      final uri = Uri.https(heroku_2_base_url, 'v3/covid-19/all');
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        return Global.fromJsonMap(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
      CoronaBloc().globalBehaviorSubject$.addError(response.statusCode);
    } catch (e, s) {
      logger.severe('error while calling getGlobal api', e, s);
      CoronaBloc().globalBehaviorSubject$.addError(e, s);
    }
    return null;
  }

  Future<Serbia> getSerbia() async {
    try {
      final uri = Uri.https(
        heroku_2_base_url,
        'v3/covid-19/countries/Serbia',
      );

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        return Serbia.fromJsonMap(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
      CoronaBloc().serbiaBehaviorSubject$.addError(response.statusCode);
    } catch (e, s) {
      logger.severe('error while calling getSerbia api', e, s);
      CoronaBloc().serbiaBehaviorSubject$.addError(e, s);
    }
    return null;
  }
}
