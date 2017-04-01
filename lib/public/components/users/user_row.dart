// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/public/service/match_service.dart';
import 'package:angular2/core.dart';
import 'package:GPingPong/public/service/user_service.dart';
import 'package:GPingPong/model/user.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:GPingPong/public/common/rated_text.dart';
import 'package:GPingPong/public/common/filter.dart';

@Component(
    selector: 'user-row',
//    styleUrls: const ['users.css'],
    styles: const ["""
    .left-rating {
      float: right;
      line-height: 37px;
    }
    """],
    template: """
      <rated-text [score]="user.rating.score">{{user.name}}</rated-text>
      <material-button (trigger)="pressedRating()">
        Rating
      </material-button>
      <div class="left-rating">
          <rated-text [score]="user.rating.score" >
              <b>{{user.rating.score | number:'0.1-1'}}</b>
          </rated-text>
          ({{user.rating.gamesWon | number:'3.0'}} / {{user.rating.gamesPlayed - user.rating.gamesWon | number:'3.0'}})
      </div>
    """,
    directives: const [materialDirectives, RatedText],
    providers: const [materialProviders, UserService, MatchService],
    pipes: const [FilterPipe]
)
class UserRow {

  @Input()
  User user;

  @Output("showRating")
  EventEmitter<User> showRating = new EventEmitter<User>();

  double getUncertainty(User u){
    if(u.rating.gamesPlayed >= Rating.MIN_MATCHES){
      return 0.0;
    }
    double delta = pow(Rating.MIN_MATCHES - u.rating.gamesPlayed, 2) * 5;
    return max(delta, 30);
  }

  void pressedRating(){
    showRating.emit(user);
  }



}
