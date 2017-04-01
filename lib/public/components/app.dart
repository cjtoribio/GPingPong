// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:GPingPong/public/common/rating_chart.dart';
import 'package:GPingPong/public/components/matches/matches.dart';
import 'package:GPingPong/public/components/users/users.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:GPingPong/public/dialogs/new_match/component.dart';
import 'package:GPingPong/public/common/filter.dart';
import 'package:angular2/router.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app.css'],
  templateUrl: 'app.html',
  directives: const [materialDirectives, NewMatchDialog, UsersComponent, MatchesComponent, RatingChart],
  providers: const [materialProviders],
  pipes: const [FilterPipe]
)
class AppComponent {

//  final Router router;

  AppComponent()  { }

  List<String> tabLabels = ['Users', 'Matches'];
  List<String> tabUrls = ['/users', '/matches'];

  void onTabChange(TabChangeEvent e) {
//    this.router.navigateByUrl(tabUrls[e.newIndex]);
//    print(tabUrls[e.newIndex]);
  }

}
