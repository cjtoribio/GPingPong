// GENERATED CODE - DO NOT MODIFY BY HAND

part of endpoints.sample;

// **************************************************************************
// Generator: ApiGenerator
// Target: class Sample
// **************************************************************************

class JaguarSample implements RequestHandler {
  static const List<RouteBase> routes = const <RouteBase>[
    const Route(path: '/ping', methods: const <String>['GET']),
    const Route(
        path: '/pong',
        methods: const <String>['POST'],
        statusCode: 201,
        headers: const {"pong-header": "silly-pong"}),
    const Route(
        path: '/echo/pathparam/:message', methods: const <String>['POST']),
    const Route(path: '/echo/queryparam', methods: const <String>['POST'])
  ];

  final Sample _internal;

  factory JaguarSample() {
    final instance = new Sample();
    return new JaguarSample.from(instance);
  }
  JaguarSample.from(this._internal);

  Future<Response> handleRequest(Request request, {String prefix: ''}) async {
    prefix += '/api2';
    ContextImpl ctx = new ContextImpl(request);
    bool match = false;

//Handler for ping
    match = routes[0]
        .match(request.uri.path, request.method, prefix, ctx.pathParams);
    if (match) {
      Response<String> rRouteResponse0 = new Response(null);
      try {
        rRouteResponse0.statusCode = 200;
        rRouteResponse0.headers
            .set('content-type', 'text/plain; charset=utf-8');
        rRouteResponse0.value = _internal.ping();
        return rRouteResponse0;
      } catch (e) {
        rethrow;
      }
    }

//Handler for pong
    match = routes[1]
        .match(request.uri.path, request.method, prefix, ctx.pathParams);
    if (match) {
      Response<String> rRouteResponse0 = new Response(null);
      try {
        rRouteResponse0.statusCode = 201;
        rRouteResponse0.headers['pong-header'] = 'silly-pong';
        rRouteResponse0.headers
            .set('content-type', 'text/plain; charset=utf-8');
        rRouteResponse0.value = _internal.pong();
        return rRouteResponse0;
      } catch (e) {
        rethrow;
      }
    }

//Handler for echoPathParam
    match = routes[2]
        .match(request.uri.path, request.method, prefix, ctx.pathParams);
    if (match) {
      Response<String> rRouteResponse0 = new Response(null);
      try {
        rRouteResponse0.statusCode = 200;
        rRouteResponse0.headers
            .set('content-type', 'text/plain; charset=utf-8');
        rRouteResponse0.value = _internal.echoPathParam(
          (ctx.pathParams.getField('message')),
        );
        return rRouteResponse0;
      } catch (e) {
        rethrow;
      }
    }

//Handler for echoQueryParam
    match = routes[3]
        .match(request.uri.path, request.method, prefix, ctx.pathParams);
    if (match) {
      Response<String> rRouteResponse0 = new Response(null);
      try {
        rRouteResponse0.statusCode = 200;
        rRouteResponse0.headers
            .set('content-type', 'text/plain; charset=utf-8');
        rRouteResponse0.value = _internal.echoQueryParam(
          message: (ctx.queryParams.getField('message')),
        );
        return rRouteResponse0;
      } catch (e) {
        rethrow;
      }
    }

    return null;
  }
}
