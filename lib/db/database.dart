import 'dart:collection';
import 'dart:io';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/service/elo.dart';

class Database {

  HashMap<String , List<Rating>> ratings = {};
  HashMap<String, User> users = {};
  List<SingleMatch> matches = [];
  static Database instance = null;

  Database();

  static void start(){
    instance = new Database
        .fromFile("/Users/cjtoribio/IdeaProjects/GPingPong/historial.csv");
  }

  static Database getInstance() {
    return instance;
  }

  void saveRating(User user){
    if(!ratings.containsKey(user.ldap)){
      ratings[user.ldap] = [];
    }
    ratings[user.ldap].add(user.rating);
  }

  User getUser(String ldap){
    if(users.containsKey(ldap)){
      return users[ldap];
    }
    User u = new User(ldap, ldap);
    saveRating(u);
    users[u.ldap] = u;
    return u;
  }

  factory Database.fromFile(String path){
    var file = new File(path);
    Database db = new Database();
    var lines = file.readAsLinesSync();
    HashMap<String, User> hm = new HashMap<String, User>();
    DateTime d = new DateTime(2017, 03, 01, 10);
    for(var line in lines) {
      if(line.contains("#")){
        try {
          d = DateTime.parse(line.substring(1));
        } finally {
          continue;
        }
      }
      var spLine = line.split(',');
      User u1 = db.getUser(spLine[0]);
      User u2 = db.getUser(spLine[1]);
      int score1 = int.parse(spLine[3]);
      int score2 = int.parse(spLine[4]);
      d = db.advanceDate(d, score1 + score2);
      SingleMatch m = new SingleMatch(u1.clone(), u2.clone(), score1, score2, d);
      Elo.updateRating(m);
      db.users[u1.ldap] = m.player1;
      db.users[u2.ldap] = m.player2;
      db.saveRating(m.player1);
      db.saveRating(m.player2);
      db.matches.add(m);
    }
    return db;
  }

  DateTime advanceDate(DateTime d, int gamesPlayed) {
    d.add(new Duration(minutes: 17));
    if(d.hour >= 19){
      d = d.add(new Duration(hours: 15));
    }
    return d.add(new Duration(minutes: 3 * gamesPlayed));
  }

}