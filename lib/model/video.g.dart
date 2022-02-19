// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      description: json['description'] as String,
      sources: json['sources'] as String,
      subtitle: json['subtitle'] as String,
      thumb: json['thumb'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'description': instance.description,
      'sources': instance.sources,
      'subtitle': instance.subtitle,
      'thumb': instance.thumb,
      'title': instance.title,
    };
