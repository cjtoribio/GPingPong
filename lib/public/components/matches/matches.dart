// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/public/service/match_service.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:GPingPong/public/dialogs/new_match/component.dart';
import 'package:GPingPong/public/common/rated_text.dart';
import 'package:GPingPong/public/common/filter.dart';

@Component(
    selector: 'matches-component',
//    styleUrls: const ['app.css'],
    templateUrl: 'matches.html',
    directives: const [materialDirectives, NewMatchDialog, RatedText],
    providers: const [materialProviders, MatchService],
    pipes: const [FilterPipe]
)
class MatchesComponent {
  final MatchService matchService;

  List<SingleMatch> matches = [];

  String searchCriteria = "";

  MatchesComponent(this.matchService)  {
    matchService.getMatches().then((matches) {
      this.matches = new List.from(matches.reversed);
      print(matches[0]);
    });
  }

  List<SingleMatch> getMatches(){
    return matches;
  }

}
