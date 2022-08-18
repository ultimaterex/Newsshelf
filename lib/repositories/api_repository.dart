// implicit interfaces [https://dart.dev/guides/language/language-tour#implicit-interfaces]
import 'package:fpdart/fpdart.dart';
import 'package:news_shelf/models/news_result.dart';

abstract class ApiRepository {
  ApiRepository();

  /// use [TaskEither] to perform an async request in a composable way.
  TaskEither<String, NewsResult> searchDefault(String query);

  TaskEither<String, NewsResult> searchAll(String query,
      {String? language, String? country});

  TaskEither<String, NewsResult> searchByTitle(String query,
      {String? language, String? country});

  TaskEither<String, NewsResult> searchByAuthor(String query,
      {String? language, String? country});

  TaskEither<String, NewsResult> searchByDescription(String query,
      {String? language, String? country});

  TaskEither<String, NewsResult> getTopHeadlines(
      {String? topic, String? language, String? country});
}
