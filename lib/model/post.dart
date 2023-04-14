import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  String header;
  String description;
  int likes;
  String user;
  String imageUrl;
  String userId;
  String date;

  Post({
    required this.header,
    required this.description,
    required this.likes,
    required this.user,
    required this.imageUrl,
    required this.userId,
    required this.date,
  });


  factory Post.fromJson(Map<String,dynamic> data) => _$PostFromJson(data);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

