import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:news_shelf/controllers/v1/news_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Defines application's top-level routes
class V1Routes {
  final ProviderContainer provider;

  NewsController get news => provider.read(newsProvider);

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
    final url = request.url;
    final topic = url.queryParameters['topic'];
    final language = url.queryParameters['language'];
    final country = url.queryParameters['country'];

    return news.getTopHeadlines(
        url: url, topic: topic, language: language, country: country);
  }

  Future<Response> getArticleByKeyword(Request request) async {
    final url = request.url;

    return url.queryParameters.containsKey('query').match(
        () => Response.badRequest(body: "Parameter 'query' was not supplied"),
        () {
      final query = url.queryParameters['query']!;
      return news.searchNews(url: url, query: query);
        });
  }

  Future<Response> getArticleByAuthor(Request request) async {
    return Response.ok(jsonEncode('Win'));
  }
}
