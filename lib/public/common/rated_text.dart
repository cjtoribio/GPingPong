// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'rated-text',
//  styleUrls: const ['app.css'],
  templateUrl: 'rated_text.html',
  directives: const [materialDirectives],
  providers: const [materialProviders],
)
class RatedText {

  RatedText();

  @Input('score')
  double score;

  @Input('bold')
  bool bold;

  String getColor(){
    if(score >= 2400) return 'red';
    if(score >= 2200) return 'orange';
    if(score >= 1900) return '#a0a';
    if(score >= 1600) return 'blue';
    if(score >= 1400) return '#03A89E';
    if(score >= 1200) return 'green';
    return 'gray';
  }


}
