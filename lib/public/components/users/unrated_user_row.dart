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
    selector: 'unrated-user-row',
//    styleUrls: const ['users.css'],
    template: """
      {{user.name}}
      <div [ngStyle]="{'float': 'right'}">
          [{{user.rating.score - getUncertainty(user) | number:'0.0-0'}} ~
          {{user.rating.score + getUncertainty(user) | number:'0.0-0'}}]
          ({{user.rating.gamesWon | number:'3.0'}} / {{user.rating.gamesPlayed - user.rating.gamesWon | number:'3.0'}})
      </div>
    """,
    directives: const [materialDirectives, RatedText],
    providers: const [materialProviders, UserService, MatchService],
    pipes: const [FilterPipe]
)
class UnratedUserRow {

  @Input()
  User user;

  double getUncertainty(User u){
    if(u.rating.gamesPlayed >= Rating.MIN_MATCHES){
      return 0.0;
    }
    double delta = pow(Rating.MIN_MATCHES - u.rating.gamesPlayed, 2) * 5;
    return max(delta, 30);
  }

}
