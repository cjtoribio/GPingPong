import 'dart:math';

class Rating extends Comparable<Rating> {
  static const double START_RATING = 1500.0;
  static const int MIN_MATCHES = 10;

  double score;
  int gamesPlayed;
  int gamesWon;
  DateTime startDate;

  Rating() {
    score = START_RATING;
    gamesPlayed = 0;
    gamesWon = 0;
    startDate = new DateTime.now();
  }

  factory Rating.fromJson(Map<String, dynamic> props) {
    Rating rating = new Rating();
    rating.score = double.parse(props['score'].toString());
    rating.gamesPlayed = int.parse(props['gamesPlayed'].toString());
    rating.gamesWon = int.parse(props['gamesWon'].toString());
    rating.startDate = DateTime.parse(props['startDate']);
    return rating;
  }

  void update(double newScore) {
    score = newScore;
    gamesPlayed += 1;
  }

  double getVariance() {
    return 1 + 7 / sqrt(gamesPlayed + 1);
  }

  Rating clone() {
    Rating r = new Rating();
    r.score = score;
    r.gamesPlayed = gamesPlayed;
    r.gamesWon = gamesWon;
    r.startDate = startDate;
    return r;
  }

  Map toJson() => {
    'score': score,
    'gamesPlayed': gamesPlayed,
    'gamesWon': gamesWon,
    'startDate': startDate.toIso8601String()
  };

  @override
  int compareTo(Rating other) {
    return score.compareTo(other.score);
  }
}
