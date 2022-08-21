import 'package:dio/dio.dart' show Dio;
import 'package:fpdart/fpdart.dart';
import 'package:news_shelf/helpers/api.dart';
import 'package:news_shelf/models/news_result.dart';
import 'package:news_shelf/models/rest_client.dart';
import 'package:news_shelf/repositories/api_repository.dart';
import 'package:news_shelf/repositories/credentials_repository.dart';
import 'package:riverpod/riverpod.dart';

final gnewsRepositoryProvider = Provider((ref) {
  return GnewsApiRepository(ref.read(credentialsProvider).gnewsApiKey,
      RestClient(Dio(), baseUrl: GNewsApi.base));
});

class GnewsApiRepository implements ApiRepository {
  late String token;
  final RestClient api;

  GnewsApiRepository(this.token, this.api);

  @override
  TaskEither<String, NewsResult> searchDefault(String query,
          {String? language, String? country}) =>
      TaskEither.tryCatch(
        () async {
          final response = await api.getArticlesBySearch(token,
              query: query, country: country, language: language);
          return response.toNewsResult();
        },
        (error, __) => 'Unknown error: $error',
      );

  @override
  TaskEither<String, NewsResult> searchByTitle(String query,
          {String? language, String? country}) =>
      TaskEither.tryCatch(
        () async {
          final response = await api.getArticlesBySearch(token,
              query: query, searchIn: "title");
          return response.toNewsResult();
        },
        (error, __) => 'Unknown error: $error',
      );

  @override
  TaskEither<String, NewsResult> searchByAuthor(String query,
          {String? language, String? country}) =>
      TaskEither.tryCatch(
        () async {
          throw UnimplementedError(
              "GnewsApi Does not support searching by Author");
        },
        (error, __) => 'Unknown error: $error',
      );

  @override
  TaskEither<String, NewsResult> searchByDescription(String query,
          {String? language, String? country}) =>
      TaskEither.tryCatch(
        () async {
          final response = await api.getArticlesBySearch(token,
              query: query,
              searchIn: "description",
              language: language,
              country: country);
          return response.toNewsResult();
        },
        (error, __) => 'Unknown error: $error',
      );

  @override
  TaskEither<String, NewsResult> getTopHeadlines(
          {String? topic, String? language, String? country}) =>
      TaskEither.tryCatch(
        () async {
          final response = await api.getTopHeadlines(token,
              topic: topic, language: language, country: country);
          return response.toNewsResult();
        },
        (error, __) => 'Unknown error: $error',
      );

  @override
  TaskEither<String, NewsResult> searchComplex(String query,
          {String? searchIn,
          String? language,
          String? country,
          String? from,
          String? to}) =>
      TaskEither.tryCatch(
        () async {
          final response = await api.getArticlesBySearch(token,
              query: query,
              searchIn: searchIn,
              language: language,
              country: country,
              from: from,
              to: to);
          return response.toNewsResult();
        },
        (error, __) => 'Unknown error: $error',
      );
}
