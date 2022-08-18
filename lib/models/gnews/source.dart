import 'package:json_annotation/json_annotation.dart';


part 'source.g.dart';

@JsonSerializable()
class Source {
  String name;
  String url;

  Source(this.name, this.url);

  /// Connect the generated [_$SourceFromJson] function to the `fromJson`
  /// factory.
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  /// Connect the generated [_$SourceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SourceToJson(this);

}
