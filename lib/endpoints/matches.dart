/// File: main.dart
library endpoints.matches;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:GPingPong/db/database.dart';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/service/elo.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/interceptors.dart';
import 'package:GPingPong/model/user.dart';

part 'matches.g.dart';

/// Example of basic API class
@Api(path: '/api/matches')
class Matches {
  WrapEncodeToJson jsonEncoder() => new WrapEncodeToJson();
  WrapDecodeJsonMap jsonDecoder() => new WrapDecodeJsonMap();
  WrapEncodeListToJson listEncoder() => new WrapEncodeListToJson();

  /// Example of basic route
  @Route(path: '/', methods: const <String>['GET'],
      headers: const {'Access-Control-Allow-Origin': '*'})
  @Wrap(const [#jsonEncoder])
  Map getMatches() {
    try {
      return {'data': Database.getInstance().matches};
    } catch (e) {
      print(e);
    }
  }

}