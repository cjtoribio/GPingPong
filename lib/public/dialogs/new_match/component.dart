// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:GPingPong/service/elo.dart';
import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/public/service/user_service.dart';

@Component(
  selector: 'new-match-dialog',
  styleUrls: const ['style.css'],
  templateUrl: 'view.html',
  directives: const [materialDirectives],
  providers: const [materialProviders, UserService],
)
class NewMatchDialog {

  MatchPlayer player1 = new MatchPlayer();
  MatchPlayer player2 = new MatchPlayer();
  final UserService userService;

  NewMatchDialog(this.userService);

  /// Modal component that hosts the inner MaterialDialog in a centered overlay.
  @ViewChild('wrappingModal')
  ModalComponent wrappingModal;

  /// Opens the dialog.
  void open() {
    wrappingModal.open();
  }

  void save(){
    Future.wait(
        [userService.getUser(player1.name),userService.getUser(player2.name)]
    ).then((List<User> users) {
      User p1 = users[0];
      User p2 = users[1];
      if(p1 == null || p2 == null)return;
      int s1 = int.parse(player1.score);
      int s2 = int.parse(player2.score);
      SingleMatch sm = new SingleMatch(p1,p2,s1,s2);
      userService.submitMatch(sm)
      .then((users) {
        wrappingModal.close();
      });
    });
  }
}

class MatchPlayer {
  String name;
  String score;
}
