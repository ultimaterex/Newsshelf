import 'dart:convert';

import 'package:news_shelf/routes/v1/news_routes.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Defines application's top-level routes
class V1Routes {
  final ProviderContainer provider;

  V1Routes(this.provider);

  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      final _aboutApp = {
        'name': 'News Shelf',
        'version': 'v1.0.0',
        'description': 'A extensible multi-source news fetch api'
      };
      return Response.ok(jsonEncode(_aboutApp));
    });

    router.mount('/news', NewsRoutes(provider).router);

    router.all('/<ignore|.*>',
        (Request r) => Response.notFound(jsonEncode({'message': 'Route not defined'})));

    return router;
  }
}
