import 'dart:async';
import 'package:GPingPong/db/database.dart';
import 'package:jaguar/jaguar.dart';
import 'package:GPingPong/endpoints/users.dart';
import 'package:GPingPong/endpoints/matches.dart';
import 'package:GPingPong/endpoints/sample.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:jaguar_shelf/jaguar_shelf.dart';


Future main(List<String> args) async {

  Database.start();

  Jaguar app = new Jaguar(port: 8080, multiThread: true);

  final shelfHandler = new ShelfHandler(
      createStaticHandler('./build/web', defaultDocument: 'index.html')
  );

  app.addApi(shelfHandler);
  app.addApi(new JaguarSample());
  app.addApi(new JaguarUsers());
  app.addApi(new JaguarMatches());

  await app.serve();

}

//void main() {
//  var handler = createStaticHandler('./build/web',
//      defaultDocument: 'index.html');
//
//  io.serve(handler, 'localhost', 8080);
//}