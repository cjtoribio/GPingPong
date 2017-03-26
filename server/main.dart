import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:GPingPong/endpoints/sample.dart';
import 'package:GPingPong/endpoints/users.dart';
import 'package:GPingPong/endpoints/matches.dart';


Future main(List<String> args) async {

  Jaguar app = new Jaguar(port: 8888, multiThread: true);
  app.addApi(new JaguarSample());
  app.addApi(new JaguarUsers());
  app.addApi(new JaguarMatches());
  await app.serve();

}