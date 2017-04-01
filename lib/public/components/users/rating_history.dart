// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/public/common/rating_chart.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'rating-history-dialog',
//  styleUrls: const ['hello_dialog.css'],
  templateUrl: 'rating_history.html',
  directives: const [materialDirectives, RatingChart],
  providers: const [materialProviders],
)
class RatingHistory {
  /// Modal component that hosts the inner MaterialDialog in a centered overlay.
  @ViewChild('wrappingModal')
  ModalComponent wrappingModal;

  @ViewChild("ratingChart")
  RatingChart ratingChart;

  /// Opens the dialog.
  void open(User user) {
    ratingChart.open(user);
    wrappingModal.open();
  }

  void close(){
    wrappingModal.close();
  }
}
