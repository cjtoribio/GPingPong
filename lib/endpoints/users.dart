/// File: main.dart
library endpoints.users;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:GPingPong/db/database.dart';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/service/elo.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/interceptors.dart';
import 'package:GPingPong/model/user.dart';

part 'users.g.dart';

/// Example of basic API class
@Api(path: '/api/users')
class Users {
  WrapEncodeToJson jsonEncoder() => new WrapEncodeToJson();
  WrapDecodeJsonMap jsonDecoder() => new WrapDecodeJsonMap();
  WrapEncodeListToJson listEncoder() => new WrapEncodeListToJson();

  /// Example of basic route
  @Route(path: '/', methods: const <String>['GET'],
    headers: const {'Access-Control-Allow-Origin': '*'})
  @Wrap(const [#jsonEncoder])
  Map getUsers() {
    List<User> users = new List.from(Database.getInstance().users.values);
    users.sort(User.compareByRating);
    List<User> sortedUsers = new List<User>.from(users.reversed);
    return {'data': sortedUsers};
  }

  @Route(path: '/rating-history/:ldap', methods: const <String>['GET'],
      headers: const {'Access-Control-Allow-Origin': '*'})
  @Wrap(const [#jsonEncoder])
  Map getRatingHistory(String ldap){
    return {'data': Database.getInstance().ratings[ldap]};
  }

}

