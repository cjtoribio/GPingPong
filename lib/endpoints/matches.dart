/// File: main.dart
library endpoints.matches;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
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
      return {'data': processFile()};
    } catch (e) {
      print(e);
    }
  }

}


List<SingleMatch> processFile(){
  var file = new File("/Users/cjtoribio/IdeaProjects/GPingPong/historial.csv");
  var lines = file.readAsLinesSync();
  HashMap<String, User> hm = new HashMap<String, User>();
  List<SingleMatch> matches = [];
  for(var line in lines) {
    var spLine = line.split(',');
    String name1 = spLine[0];
    String name2 = spLine[1];
    if (!hm.containsKey(name1)) {
      hm[name1] = new User(name1, name1);
    }
    if (!hm.containsKey(name2)) {
      hm[name2] = new User(name2, name2);
    }
    int score1 = int.parse(spLine[3]);
    int score2 = int.parse(spLine[4]);
    hm[name1] = hm[name1].clone();
    hm[name2] = hm[name2].clone();
    SingleMatch m = new SingleMatch(hm[name1], hm[name2], score1, score2);
    Elo.updateRating(m);
    matches.add(m);
  }
  return matches;
}

