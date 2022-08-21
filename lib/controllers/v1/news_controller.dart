import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:news_shelf/models/news_result.dart';
import 'package:news_shelf/repositories/api_repository.dart';
import 'package:news_shelf/repositories/gnews_api_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shelf/shelf.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_memory/stash_memory.dart';

final newsProvider = Provider((ref) => NewsController(ref));

final newsCacheProvider = Provider((ref) => newMemoryCache(
    cacheName: "newsCache",
    maxEntries: 25,
    expiryPolicy: const CreatedExpiryPolicy(Duration(minutes: 10))));

class NewsController {
  final ProviderRef ref;

  ApiRepository get newsRepository => ref.read(gnewsRepositoryProvider);

  NewsController(this.ref);

  /// Retrieves the searched articles by querying cached data or querying the external API
  Future<Response> searchNews(
          {required Uri url,
          required String query,
          String? language,
          String? country}) async =>
      await _cacheResponseHandler(
          url,
          () => newsRepository.searchDefault(query,
              country: country, language: language));

  /// Retrieves the searched articles by querying cached data or querying the external API, Allows for more Parameters
  Future<Response> searchNewsComplex(
          {required Uri url,
          required String query,
          String? language,
          String? country,
          String? searchIn,
          String? from,
          String? to}) async =>
      await _cacheResponseHandler(
          url,
          () => newsRepository.searchComplex(query,
              country: country,
              language: language,
              searchIn: searchIn,
              from: from,
              to: to));

  /// Retrieves the top headlines by querying cached data or querying the external API
  Future<Response> getTopHeadlines(
          {required Uri url,
          String? topic,
          String? language,
          String? country}) async =>
      await _cacheResponseHandler(
          url,
          () => newsRepository.getTopHeadlines(
              topic: topic, country: country, language: language));

  /// Checks the cache for the [uri] key and retrieves it
  /// if read through cache falls through it then queries the external API through [function]
  /// May return [Response.ok] or [Response.internalServerError]
  Future<Response> _cacheResponseHandler(
      Uri url, TaskEither<String, NewsResult> Function() function) async {
    return await _queryNewsCache(url).run().then((value) => value.match(
        (cached) => Response.ok(jsonEncode(cached)),
        () async => (await function().run()).match(
            (error) => Response.internalServerError(body: jsonEncode(error)),
            (data) =>
                Response.ok(jsonEncode(_registerCache(url, data).toJson())))));
  }

  /// Asks the in-memory cache if there is a cached [NewsResult], and returns the cachedResult with source Metadata
  /// if not, it passes through the function and stores the result.
  /// This will only use the [uri] as a key so it won't work for requests that include a body.
  Task<Option<NewsResult>> _queryNewsCache(Uri uri) {
    final cache = ref.read(newsCacheProvider);
    final key = _getKey(uri);

    // check if cache contains
    return Task(() async {
      if (!(await cache.containsKey(key))) return none();
      final cachedResult = await cache.get(key) as NewsResult;
      return some(cachedResult.copyWith(
          metadata: <String, String>{"source": "cache"}
            ..addAll(cachedResult.metadata)));
    });
  }

  /// Stored the [NewsResult] in memory cache , and returns a modified object with correct source data
  /// This will only use the [uri] as a key so it won't work for requests that include a body.
  NewsResult _registerCache(Uri uri, NewsResult result) {
    ref
        .read(newsCacheProvider)
        .put(_getKey(uri), result)
        .then((value) => result);
    return result.copyWith(
        metadata: <String, String>{"source": "fresh"}..addAll(result.metadata));
  }

  static String _getKey(Uri uri) => uri.query.hashCode.toString();
}
