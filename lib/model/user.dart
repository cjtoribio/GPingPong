import 'package:GPingPong/model/rating.dart';


class User {

  String name;
  String ldap;
  Rating rating;

  User(this.name, this.ldap) {
    this.rating = new Rating();
  }

  static int compareByRating(User a, User b){
    return a.rating.compareTo(b.rating);
  }

  factory User.fromJson(Map<String, dynamic> props) {
    User user = new User(props['name'], props['ldap']);
    if(props.containsKey('rating')) {
      user.rating = new Rating.fromJson(props['rating']);
    }
    return user;
  }
  User clone(){
    User u = new User(name, ldap);
    u.rating = rating.clone();
    return u;
  }

  Map toJson() => {'ldap': ldap, 'name': name, 'rating': rating.toJson()};

}

int toInt(v) => v is int ? v : int.parse(v);
