// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      header: json['header'] as String,
      description: json['description'] as String,
      likes: json['likes'] as int,
      user: json['user'] as String,
      imageUrl: json['imageUrl'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'header': instance.header,
      'description': instance.description,
      'likes': instance.likes,
      'user': instance.user,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'date': instance.date,
    };
