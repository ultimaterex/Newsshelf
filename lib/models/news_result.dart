import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/models/article.dart';

part 'news_result.g.dart';

@JsonSerializable()
class NewsResult {
  final int count;

  final List<Article> articles;

  NewsResult(this.count, this.articles);

  /// Connect the generated [_$NewsResultFromJson] function to the `fromJson`
  /// factory.
  factory NewsResult.fromJson(Map<String, dynamic> json) =>
      _$NewsResultFromJson(json);

  /// Connect the generated [_$NewsResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NewsResultToJson(this);
}
