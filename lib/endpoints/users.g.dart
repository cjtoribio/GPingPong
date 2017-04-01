// GENERATED CODE - DO NOT MODIFY BY HAND

part of endpoints.users;

// **************************************************************************
// Generator: ApiGenerator
// Target: class Users
// **************************************************************************

class JaguarUsers implements RequestHandler {
  static const List<RouteBase> routes = const <RouteBase>[
    const Route(
        path: '/',
        methods: const <String>['GET'],
        headers: const {'Access-Control-Allow-Origin': '*'}),
    const Route(
        path: '/rating-history/:ldap',
        methods: const <String>['GET'],
        headers: const {'Access-Control-Allow-Origin': '*'})
  ];

  final Users _internal;

  factory JaguarUsers() {
    final instance = new Users();
    return new JaguarUsers.from(instance);
  }
  JaguarUsers.from(this._internal);

  Future<Response> handleRequest(Request request, {String prefix: ''}) async {
    prefix += '/api/users';
    ContextImpl ctx = new ContextImpl(request);
    bool match = false;

//Handler for getUsers
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
        rRouteResponse0.value = _internal.getUsers();
        Response<String> rRouteResponse1 = iEncodeToJson0.post(
          rRouteResponse0,
        );
        return rRouteResponse1;
      } catch (e) {
        await iEncodeToJson0?.onException();
        rethrow;
      }
    }

//Handler for getRatingHistory
    match = routes[1]
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
        rRouteResponse0.value = _internal.getRatingHistory(
          (ctx.pathParams.getField('ldap')),
        );
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
