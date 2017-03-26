// GENERATED CODE - DO NOT MODIFY BY HAND

part of endpoints.matches;

// **************************************************************************
// Generator: ApiGenerator
// Target: class Matches
// **************************************************************************

class JaguarMatches implements RequestHandler {
  static const List<RouteBase> routes = const <RouteBase>[
    const Route(
        path: '/',
        methods: const <String>['GET'],
        headers: const {'Access-Control-Allow-Origin': '*'})
  ];

  final Matches _internal;

  factory JaguarMatches() {
    final instance = new Matches();
    return new JaguarMatches.from(instance);
  }
  JaguarMatches.from(this._internal);

  Future<Response> handleRequest(Request request, {String prefix: ''}) async {
    prefix += '/api/matches';
    ContextImpl ctx = new ContextImpl(request);
    bool match = false;

//Handler for getMatches
    match = routes[0]
        .match(request.uri.path, request.method, prefix, ctx.pathParams);
    if (match) {
      Response<Map> rRouteResponse0 = new Response(null);
      EncodeToJson iEncodeToJson0;
      try {
        final RouteWrapper wEncodeToJson0 = _internal.jsonEncoder();
        iEncodeToJson0 = wEncodeToJson0.createInterceptor();
        rRouteResponse0.statusCode = 200;
        rRouteResponse0.headers['Access-Control-Allow-Origin'] = '*';
        rRouteResponse0.headers
            .set('content-type', 'text/plain; charset=utf-8');
        rRouteResponse0.value = _internal.getMatches();
        Response<String> rRouteResponse1 = iEncodeToJson0.post(
          rRouteResponse0,
        );
        return rRouteResponse1;
      } catch (e) {
        await iEncodeToJson0?.onException();
        rethrow;
      }
    }

    return null;
  }
}
