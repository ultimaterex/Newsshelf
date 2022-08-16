import 'article.dart';
import 'package:json_annotation/json_annotation.dart';


part 'gnews_result.g.dart';

@JsonSerializable()
class GnewsResult {
  int totalArticles;
  List<Article> articles;

  GnewsResult(this.totalArticles, this.articles);

  /// Connect the generated [_$GnewsResultFromJson] function to the `fromJson`
  /// factory.
  factory GnewsResult.fromJson(Map<String, dynamic> json) => _$GnewsResultFromJson(json);

  /// Connect the generated [_$GnewsResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GnewsResultToJson(this);
}

