// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

myUser _$myUserFromJson(Map<String, dynamic> json) => myUser(
      name: json['name'] as String,
      surname: json['surname'] as String,
      nick: json['nick'] as String,
      follower: json['follower'] as int,
      following: json['following'] as int,
      imageUrl: json['imageUrl'] as String,
      userId: json['userId'] as String,
      private: json['private'] as bool,
    );

Map<String, dynamic> _$myUserToJson(myUser instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'nick': instance.nick,
      'follower': instance.follower,
      'following': instance.following,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'private': instance.private,
    };
