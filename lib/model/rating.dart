
class Rating extends Comparable<Rating> {
  static const double START_RATING = 1500.0;

  double score;
  int gamesPlayed;
  int gamesWon;

  Rating() {
    score = START_RATING;
    gamesPlayed = 0;
    gamesWon = 0;
  }

  factory Rating.fromJson(Map<String, dynamic> props) {
    Rating rating = new Rating();
    rating.score = double.parse(props['score'].toString());
    rating.gamesPlayed = int.parse(props['gamesPlayed'].toString());
    rating.gamesWon = int.parse(props['gamesWon'].toString());
    return rating;
  }

  void update(double newScore) {
    score = newScore;
    gamesPlayed += 1;
  }

  Rating clone() {
    Rating r = new Rating();
    r.score = score;
    r.gamesPlayed = gamesPlayed;
    return r;
  }

  Map toJson() => {
    'score': score,
    'gamesPlayed': gamesPlayed,
    'gamesWon': gamesWon
  };

  @override
  int compareTo(Rating other) {
    return score.compareTo(other.score);
  }
}
