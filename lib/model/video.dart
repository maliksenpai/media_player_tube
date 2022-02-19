import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video{
   String description;
   String sources;
   String subtitle;
   String thumb;
   String title;

   Video({required this.description, required this.sources, required this.subtitle, required this.thumb, required this.title});

   factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

   Map<String, dynamic> toJson() => _$VideoToJson(this);
}