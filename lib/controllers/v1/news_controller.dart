import 'dart:convert';

import 'package:news_shelf/repositories/gnews_api_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shelf/shelf.dart';

final newsProvider = Provider((ref) => NewsController(ref));

class NewsController {
  final ProviderRef ref;

  NewsController(this.ref);

  Future<Response> searchNews({required String query}) async {
    final resultTask =
        await ref.read(gnewsRepositoryProvider).searchDefault(query).run();
    return resultTask.match(
        (l) => Response.internalServerError(body: jsonEncode(l)),
        (r) => Response.ok(jsonEncode(r.toJson())));
  }

  Future<Response> getTopHeadlines(
      {String? topic, String? language, String? country}) async {
    final resultTask = await ref
        .read(gnewsRepositoryProvider)
        .getTopHeadlines(topic: topic, country: country, language: language)
        .run();
    return resultTask.match(
        (l) => Response.internalServerError(body: jsonEncode(l)),
        (r) => Response.ok(jsonEncode(r.toJson())));
  }
}
