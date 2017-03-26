import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'dart:io';

import 'package:angular2/core.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/service/elo.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static final _initialHeroes = [
    {'name': 'Juan Cruz Lepore', 'ldap': 'jcl'},
    {'name': 'Pablo Zimmermann', 'ldap': 'karupayun'},
    {'name': 'Carlos Toribio', 'ldap': 'carlosceballos'},
    {'name': 'Juan Pablo Paulsen', 'ldap': 'jp'},
  ];

  static final List<User> _users = _initialHeroes.map((json) => new User.fromJson(json)).toList();
  static int _nextId = _users.map((hero) => hero.id).fold(0, max) + 1;

  static Future<Response> _handler(Request request) async {
    var data;
    switch (request.method) {
      case 'GET':
        data = _users;
        break;
        final ldap = request.url.pathSegments.last;
        if (ldap != null) {
          print("one -> " + ldap);
          data = _users.firstWhere((user) => user.ldap == ldap);
        } else if(request.url.queryParameters['name'] != null) {
          print("all");
          String prefix = request.url.queryParameters['name'] ?? '';
          final regExp = new RegExp(prefix, caseSensitive: false);
          data = _users.where((hero) => hero.name.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var name = JSON.decode(request.body)['name'];
        var newHero = new User.fromJson(JSON.decode(request.body));
        _users.add(newHero);
        data = newHero;
        break;
      case 'PUT':
        var userChanges = new User.fromJson(JSON.decode(request.body));
        var targetHero = _users.firstWhere((h) => h.ldap == userChanges.ldap);
        targetHero.name = userChanges.name;
        data = targetHero;
        break;
      case 'DELETE':
        var ldap = request.url.pathSegments.last;
        _users.removeWhere((user) => user.ldap == ldap);
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return sendJson(data);
  }

  InMemoryDataService() : super(_handler);


  static List<User> processFile(){
    var file = new File("/Users/cjtoribio/IdeaProjects/GPingPong/historial.csv");
    var lines = file.readAsLinesSync();
    HashMap<String, User> hm = new HashMap<String, User>();
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
      SingleMatch m = new SingleMatch(hm[name1], hm[name2], score1, score2);
      Elo.updateRating(m);
    }

    List<User> allPlayers = [];
    for(User p in hm.values){
      allPlayers.add(p);
    }
    allPlayers.sort(User.compareByRating);
    for(User p in allPlayers){
      print(p.name + "\t" + p.rating.gamesPlayed.toString() + "\t" + p.rating.score.toString());
    }
    return allPlayers;
  }
}
Response sendJson(data) => new Response(
    JSON.encode({'data': data}), 200,
    headers: {'content-type': 'application/json'}
);
