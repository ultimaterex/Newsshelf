import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/models/gnews/source.dart';

part 'article_metadata.g.dart';

@JsonSerializable()
class ArticleMetadata {
  String? image;
  DateTime publishedAt;
  int articleLength;
  String url;
  Source source;
  Map<String, int> wordFrequency;

  ArticleMetadata(
      {this.image,
      required this.publishedAt,
      required this.articleLength,
      required this.source,
      required this.url,
      required this.wordFrequency});

  /// Connect the generated [_$ArticleMetadataFromJson] function to the `fromJson`
  /// factory.
  factory ArticleMetadata.fromJson(Map<String, dynamic> json) =>
      _$ArticleMetadataFromJson(json);

  /// Connect the generated [_$ArticleMetadataToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticleMetadataToJson(this);
}
