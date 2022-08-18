import 'package:json_annotation/json_annotation.dart';
import 'package:news_shelf/helpers/extensions.dart';
import 'package:news_shelf/models/article.dart';
import 'package:news_shelf/models/gnews/source.dart';
import 'package:news_shelf/models/metadata.dart';
part 'gnews_article.g.dart';

@JsonSerializable()
class GnewsArticle {
  String title;
  String description;
  String content;
  String url;
  String image;
  DateTime publishedAt;
  Source source;

  GnewsArticle(this.title, this.description, this.content, this.url, this.image,
      this.publishedAt, this.source);

  /// Connect the generated [_$GnewsArticleFromJson] function to the `fromJson`
  /// factory.
  factory GnewsArticle.fromJson(Map<String, dynamic> json) =>
      _$GnewsArticleFromJson(json);

  /// Connect the generated [_$GnewsArticleToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GnewsArticleToJson(this);

  Article toArticle() {
    return Article(
        title,
        description,
        content,
        image,
        Metadata(
            url: url,
            source: source,
            articleLength: content.length,
            publishedAt: publishedAt,
            image: image,
            wordFrequency: description.getWordFrequency()));
  }
}
