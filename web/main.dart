// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:GPingPong/service/in_memory_data_service.dart';
import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';

import 'package:GPingPong/public/components/app_component.dart';
import 'package:GPingPong/model/user.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';

void main() {
  bootstrap(AppComponent,
//      [provide(Client, useClass: InMemoryDataService)]
      [provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])]
  );
}
