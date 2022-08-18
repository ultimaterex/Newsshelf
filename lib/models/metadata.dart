import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/models/gnews/source.dart';

part 'metadata.g.dart';

@JsonSerializable()
class Metadata {
  String? image;
  DateTime publishedAt;
  int articleLength;
  String url;
  Source source;
  Map<String, int> wordFrequency;

  Metadata(
      {this.image,
      required this.publishedAt,
      required this.articleLength,
      required this.source,
      required this.url,
      required this.wordFrequency});

  /// Connect the generated [_$GnewsResultFromJson] function to the `fromJson`
  /// factory.
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  /// Connect the generated [_$ArticleToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
