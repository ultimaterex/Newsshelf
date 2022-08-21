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

    router.get('/search', getArticlesByKeyword);
    router.get('/search-complex', getArticleByComplexSearch);
    router.get('/trending', getTopHeadlines);
    router.all(
        '/<ignore|.*>',
        (Request r) =>
            Response.notFound(jsonEncode({'message': 'Route not defined'})));
    return router;
  }

  Future<Response> getTopHeadlines(Request request) async {
    final url = request.url;
    final topic = url.queryParameters['topic'];
    final language = url.queryParameters['language'];
    final country = url.queryParameters['country'];

    return news.getTopHeadlines(
        url: url, topic: topic, language: language, country: country);
  }

  Future<Response> getArticlesByKeyword(Request request) async {
    final url = request.url;
    final language = url.queryParameters['language'];
    final country = url.queryParameters['country'];

    return url.queryParameters.containsKey('query').match(
        () => Response.badRequest(body: "Parameter 'query' was not supplied"),
        () {
      final query = url.queryParameters['query']!;
      return news.searchNews(
          url: url, query: query, language: language, country: country);
    });
  }

  Future<Response> getArticleByComplexSearch(Request request) async {
    final url = request.url;
    final language = url.queryParameters['language'];
    final country = url.queryParameters['country'];
    final to = url.queryParameters['to'];
    final from = url.queryParameters['from'];
    final searchIn = url.queryParameters['searchIn'];

    return url.queryParameters.containsKey('query').match(
        () => Response.badRequest(body: "Parameter 'query' was not supplied"),
        () {
      final query = url.queryParameters['query']!;
      return news.searchNewsComplex(
          url: url,
          query: query,
          language: language,
          country: country,
          to: to,
          from: from,
          searchIn: searchIn);
    });
  }
}
