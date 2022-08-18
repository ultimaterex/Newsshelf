import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/models/news_result.dart';

import 'gnews_article.dart';

part 'gnews_result.g.dart';

@JsonSerializable()
class GnewsResult {
  int totalArticles;
  List<GnewsArticle> articles;

  GnewsResult(this.totalArticles, this.articles);

  /// Connect the generated [_$GnewsResultFromJson] function to the `fromJson`
  /// factory.
  factory GnewsResult.fromJson(Map<String, dynamic> json) =>
      _$GnewsResultFromJson(json);

  /// Connect the generated [_$GnewsResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GnewsResultToJson(this);

  NewsResult toNewsResult() {
    return NewsResult(totalArticles, articles.map((e) => e.toArticle()).toList());
  }
}
