import 'package:news_shelf/models/source.dart';
import 'package:json_annotation/json_annotation.dart';


part 'article.g.dart';

@JsonSerializable()
class Article {
  String title;
  String description;
  String content;
  String url;
  String image;
  DateTime publishedAt;
  Source source;

  Article(this.title, this.description, this.content, this.url, this.image,
      this.publishedAt, this.source);


  /// Connect the generated [_$GnewsResultFromJson] function to the `fromJson`
  /// factory.
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  /// Connect the generated [_$ArticleToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}


