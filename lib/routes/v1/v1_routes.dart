import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:news_shelf/controllers/v1/news_controller.dart';
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

    router.get('/random', getArticleByKeyword);
    router.get('/search', getArticleByKeyword);
    router.get('/trending', getTopHeadlines);
    router.all(
        '/<ignore|.*>',
        (Request r) =>
            Response.notFound(jsonEncode({'message': 'Route not defined'})));
    return router;
  }

  // Future<Response> getRandomArticle(Request request) async {
  //   final resultTask = await api.getTopHeadlines().run();
  //   return resultTask.match(
  //           (l) => Response.internalServerError(body: jsonEncode(l)),
  //           (r) => Response.ok(jsonEncode(r.toJson())));
  // }

  Future<Response> getNArticles(Request request) async {
    return Response.ok(jsonEncode('Win'));
  }

  Future<Response> getTopHeadlines(Request request) async {
    final topic = request.url.queryParameters['topic'];
    final language = request.url.queryParameters['language'];
    final country = request.url.queryParameters['country'];
    return provider.read(newsProvider).getTopHeadlines(topic: topic, language: language, country: country);
  }

  Future<Response> getArticleByKeyword(Request request) async {
    return request.url.queryParameters.containsKey('query').fold(
        () => Response.badRequest(body: "Parameter 'query' was not supplied"),
        () {
      final query = request.url.queryParameters['query']!;
      return provider.read(newsProvider).searchNews(query: query);
    });
  }

  Future<Response> getArticleByAuthor(Request request) async {
    return Response.ok(jsonEncode('Win'));
  }
}
