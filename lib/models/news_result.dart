import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/models/article.dart';
import 'package:news_shelf/models/result.dart';

part 'news_result.g.dart';

@JsonSerializable()
class NewsResult extends Result {
  final int count;

  final List<Article> articles;

  NewsResult(this.count, this.articles, {metadata = const <String, String>{}})
      : super(metadata);

  /// Connect the generated [_$NewsResultFromJson] function to the `fromJson`
  /// factory.
  factory NewsResult.fromJson(Map<String, dynamic> json) =>
      _$NewsResultFromJson(json);

  /// Connect the generated [_$NewsResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NewsResultToJson(this);

  NewsResult copyWith({count, articles, metadata}) =>
      NewsResult(count ?? this.count, articles ?? this.articles,
          metadata: metadata ?? this.metadata);
}
