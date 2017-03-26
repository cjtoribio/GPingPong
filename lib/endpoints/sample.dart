/// File: main.dart
library endpoints.sample;

import 'dart:async';
import 'dart:io';
import 'package:jaguar/jaguar.dart';

part 'sample.g.dart';

/// Example of basic API class
@Api(path: '/api2')
class Sample {
  int _pingCount = 0;

  /// Example of basic route
  @Route(path: '/ping', methods: const <String>['GET'])
  String ping() => "You pinged me ${++_pingCount} times, silly!";

  /// Example of setting default status code and headers in response
  @Route(path: '/pong',
      methods: const <String>['POST'],
      statusCode: 201,
      headers: const {"pong-header": "silly-pong"})
  String pong() => "Your silly pongs have no effect on me!";

  /// Example of getting path parameter in route handler arguments
  @Route(path: '/echo/pathparam/:message', methods: const <String>['POST'])
  String echoPathParam(String message) => message ?? 'No message :(';

  /// Example of getting query parameter in route handler arguments
  @Route(path: '/echo/queryparam', methods: const <String>['POST'])
  String echoQueryParam({String message}) => message ?? 'No message :(';
}