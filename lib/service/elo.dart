import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/model/rating.dart';
import 'dart:math';


class Elo {
  static const double MAX_ELO = 3400.0;
  static const double MIN_WIN_RATE = (3.0 / 1000.0);
  static const double MAX_WIN_RATE = 1 - MIN_WIN_RATE;

  static double getNewScore(Rating p1, Rating p2, double ratio){
    double factor = 20.0;//pow(MAX_ELO - p1.score, 2) / 100000.0;
    double expFactor = pow(p1.getVariance(), 1.5) / p2.getVariance();
    double realFactor = expFactor * factor;
    double difference = (p1.score - p2.score).toDouble();
    double absDifference = difference < 0 ? -difference : difference;
    double winRate =
            0.5 + 0.0014217 * difference - 0.00000024336 * difference*absDifference
                - 0.000000002514 * pow(difference,3) + 1.991E-12
                * difference * pow(absDifference,3);

    winRate = winRate.clamp(MIN_WIN_RATE, MAX_WIN_RATE);
    return ((ratio - winRate) * realFactor + p1.score);
  }

  static void updateRating(SingleMatch m){
    double ratio = m.score1  / (m.score1 + m.score2);
    for(int i = 0; i < m.score1 + m.score2; ++i) {
      double newScore1 = getNewScore(m.player1.rating, m.player2.rating, ratio);
      double newScore2 = getNewScore(m.player2.rating, m.player1.rating, 1 - ratio);
      m.player1.rating.update(newScore1);
      m.player2.rating.update(newScore2);
    }
    m.player1.rating.gamesWon += m.score1;
    m.player2.rating.gamesWon += m.score2;
    m.player1.rating.startDate = m.date;
    m.player2.rating.startDate = m.date;
  }
}