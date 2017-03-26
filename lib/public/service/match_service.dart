import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

@Injectable()
class MatchService {

  static const _usersUrl = 'http://localhost:8888/api/matches/'; // URL to web API

  final BrowserClient _http;

  MatchService(this._http);

  Future<List<User>> getMatches() async {
    try {
      final response = await _http.get(_usersUrl);
      final matches = _extractData(response)
          .map((value) => new SingleMatch.fromJson(value))
          .toList();
      return matches;
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