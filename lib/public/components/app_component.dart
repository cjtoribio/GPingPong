// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/public/service/match_service.dart';
import 'package:angular2/core.dart';
import 'package:GPingPong/public/service/user_service.dart';
import 'package:GPingPong/model/user.dart';
import 'package:angular2_components/angular2_components.dart';

import 'dialogs/new_match/component.dart';
import '../common/rated_text.dart';
import '../common/filter.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, NewMatchDialog, RatedText],
  providers: const [materialProviders, UserService, MatchService],
  pipes: const [FilterPipe]
)
class AppComponent {
  final UserService userService;
  final MatchService matchService;

  List<User> users = [];
  List<SingleMatch> matches = [];

  String searchCriteria;

  AppComponent(this.userService, this.matchService)  {
    userService.getUsers().then((users) {
      this.users = users;
    });
    matchService.getMatches().then((matches) {
      this.matches = new List.from(matches.reversed);
      print(matches[0]);
    });
  }

  List<User> getUsers(){
    return users;
  }

  List<SingleMatch> getMatches(){
    return matches;
  }

}
