import 'package:GPingPong/model/user.dart';

class SingleMatch {
  User player1;
  User player2;
  int score1;
  int score2;

  SingleMatch(this.player1, this.player2, this.score1, this.score2);

  Map toJson(){
    return {
      'player1': player1 != null ? player1.toJson() : null,
      'player2': player2 != null ? player2.toJson() : null,
      'score1': score1,
      'score2': score2
    };
  }

  factory SingleMatch.fromJson(Map map){
    return new SingleMatch(
        new User.fromJson(map['player1']),
        new User.fromJson(map['player2']),
        map['score1'],
        map['score2']
    );

  }
}