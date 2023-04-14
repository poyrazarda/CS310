import 'package:deneme/model/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class myUser{
  String name;
  String surname;
  String nick;
  int follower;
  int following;
  String imageUrl;
  String userId;
  bool private;
  myUser({
    required this.name,
    required this.surname,
    required this.nick,
    required this.follower,
    required this.following,
    required this.imageUrl,
    required this.userId,
    required this.private,
});


  factory myUser.fromJson(Map<String,dynamic> data) => _$myUserFromJson(data);
  Map<String, dynamic> toJson() => _$myUserToJson(this);
}