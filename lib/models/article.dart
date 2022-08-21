import 'package:json_annotation/json_annotation.dart';

import 'article_metadata.dart';
part 'article.g.dart';

@JsonSerializable()
class Article {
  String title;
  String description;
  String content;
  String image;
  ArticleMetadata metadata;

  Article(
      this.title, this.description, this.content, this.image, this.metadata);

  /// Connect the generated [_$ArticleFromJson] function to the `fromJson`
  /// factory.
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// Connect the generated [_$ArticleToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
