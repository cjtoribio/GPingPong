// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/common/forms/directives/control_value_accessor.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'search-input',
//  styleUrls: const ['app.css'],
  template: """
    <material-input label="Search"
                    [(ngModel)]="searchText"
                    [trailingGlyph]="isEmpty() ? 'search' : 'close'">
    </material-input>
  """,
  directives: const [materialDirectives],
  providers: const [materialProviders],
)
class SearchInput extends ControlValueAccessor {

  SearchInput();

  String searchText;
  ChangeFunction onChange;
  TouchFunction onTouch;

  bool isEmpty(){
    return searchText == null || searchText == "";
  }

  @override
  void registerOnChange(ChangeFunction f) {
    onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {
    onTouch = f;
  }

  @override
  void writeValue(String searchText) {
    if (searchText != this.searchText) {
      this.searchText = searchText;
    }
  }
}
