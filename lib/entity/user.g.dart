// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['id'] as int,
    json['authorId'] as int,
    json['title'] as String,
    json['description'] as String,
    json['url'] as String,
    json['visited'] as int,
    Article.timeFromJson(json['createdAt'] as int?),
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'visited': instance.visited,
      'createdAt': Article.timeToJson(instance.time),
    };
