import 'dart:async';
import 'dart:convert';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:angular2/core.dart';
import 'package:GPingPong/model/user.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

@Injectable()
class UserService {

  static const _usersUrl = 'http://localhost:8080/api/users/'; // URL to web API

  final BrowserClient _http;

  UserService(this._http);

  Future<List<User>> getUsers() async {
    try {
      final response = await _http.get(_usersUrl);
      final heroes = _extractData(response)
          .map((value) => new User.fromJson(value))
          .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getUser(String ldap) async {
    try {
      final response = await _http.get('$_usersUrl/$ldap');
      return new User.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<User>> submitMatch(SingleMatch m) async {
    try {
      final response = await _http.post('$_usersUrl/match', body: m.toJson());
      List<User> users = _extractData(response).map((props) =>
          new User.fromJson(props)
      );
      return users;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Rating>> getUserRating(User u) async {
    try {
      final response = await _http.get('$_usersUrl/rating-history/' + u.ldap);
      List<Rating> ratings = _extractData(response).map((props) =>
        new Rating.fromJson(props)
      );
      return ratings;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}