// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';

import 'package:GPingPong/public/components/app.dart';
import 'package:http/browser_client.dart';

import 'package:chartjs/chartjs.dart';
import 'dart:math' as math;

void main() {


  bootstrap(AppComponent,
//      [provide(Client, useClass: InMemoryDataService)]
      [provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])]
  );
}
