// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/public/components/users/rating_history.dart';
import 'package:GPingPong/public/components/users/unrated_user_row.dart';
import 'package:GPingPong/public/components/users/user_row.dart';
import 'package:GPingPong/public/service/match_service.dart';
import 'package:angular2/core.dart';
import 'package:GPingPong/public/service/user_service.dart';
import 'package:GPingPong/model/user.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:GPingPong/public/common/rated_text.dart';
import 'package:GPingPong/public/common/filter.dart';

@Component(
    selector: 'users-component',
    styles: const ["""
      .user-row {
        border-bottom: 1px solid black;
        padding: 10px;
        display: block;
      }
      .user-row:last-child {
        border-bottom: none;
      }
      .user-list {
        max-height: 300px;
        overflow: scroll;
      }
    """],
    templateUrl: 'users.html',
    directives: const [materialDirectives, RatedText, UserRow, UnratedUserRow, RatingHistory],
    providers: const [materialProviders, UserService, MatchService],
    pipes: const [FilterPipe]
)
class UsersComponent {
  final UserService userService;

  List<User> users = [];
  List<User> unratedUsers = [];

  String searchCriteria = "";

  @ViewChild("ratingDialog")
  RatingHistory ratingDialog;


  UsersComponent(this.userService)  {
    userService.getUsers().then((users) {
      for(User u in users){
        print(u);
      }
      this.users = users.where((u) => u.rating.gamesPlayed >= Rating.MIN_MATCHES);
      double bias = this.users.map((User u) => u.rating.score).reduce((a,b) => a + b);
      bias /= this.users.length;
      this.users.forEach((User u) {
        u.rating.score += Rating.START_RATING - bias;
      });
      this.unratedUsers = users.where((u) => u.rating.gamesPlayed < Rating.MIN_MATCHES);
    });
  }


  double getUncertainty(User u){
    if(u.rating.gamesPlayed >= Rating.MIN_MATCHES){
      return 0.0;
    }
    double delta = pow(Rating.MIN_MATCHES - u.rating.gamesPlayed, 2) * 5;
    return max(delta, 30);
  }


  List<User> getUsers(){
    return users;
  }

  List<User> getUnratedUsers(){
    return unratedUsers;
  }

  void showRating(User user){
    print(user);
    ratingDialog.open(user);
  }

}
