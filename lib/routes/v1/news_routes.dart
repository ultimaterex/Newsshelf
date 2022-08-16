import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NewsRoutes {
  final ProviderContainer provider;

  NewsRoutes(this.provider);

  Router get router {
    final router = Router();

    router.get('/random', getRandomArticle);

    router.all(
        '/<ignore|.*>',
        (Request r) =>
            Response.notFound(jsonEncode({'message': 'Route not defined'})));

    return router;
  }

  Response getRandomArticle(Request request) {
    return Response.ok(jsonEncode({'hello': 'world'}));
  }

  void getNArticles() {}

  void getArticleByKeyword() {}

  void getArticleByAuthor() {}
}
