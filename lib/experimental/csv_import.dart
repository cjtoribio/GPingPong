import 'dart:collection';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/service/elo.dart';

main() async {
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
  int s = allPlayers.map((u) => u.rating.score).reduce((a,b) => a+b);
  print(Rating.START_RATING - s / allPlayers.length);

  for(User p in allPlayers){
    p.rating.score += Rating.START_RATING - s / allPlayers.length;
    print(p.name + "\t" + p.rating.gamesPlayed.toString() + "\t" + p.rating.score.toString());
  }
//  print("${await (file.readAsString(encoding: ASCII))}");
}

