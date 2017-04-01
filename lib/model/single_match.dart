import 'package:GPingPong/model/user.dart';

class SingleMatch {
  User player1;
  User player2;
  int score1;
  int score2;
  DateTime date;

  SingleMatch(this.player1, this.player2, this.score1, this.score2, [this.date]);

  Map toJson(){
    return {
      'player1': player1 != null ? player1.toJson() : null,
      'player2': player2 != null ? player2.toJson() : null,
      'score1': score1,
      'score2': score2,
      'date': date.toIso8601String()
    };
  }

  factory SingleMatch.fromJson(Map map){
    return new SingleMatch(
        new User.fromJson(map['player1']),
        new User.fromJson(map['player2']),
        map['score1'],
        map['score2'],
        DateTime.parse(map['date'])
    );

  }
}