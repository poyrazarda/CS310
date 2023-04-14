import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_auth.dart';
import 'package:deneme/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/post.dart';


class StoreService{

  static final myStore = FirebaseFirestore.instance;


  static void addUser(User? user, myUser myuser){myStore.collection("users").doc("${user!.uid}").set(myuser.toJson());}

  static String addPosttoUser(User? user, Post post){
    return myStore.collection("users").doc("${user!.uid}").collection("posts").doc("${user.uid}${post.date}").set(post.toJson()).toString();
  }

  static Stream<QuerySnapshot> getPosts(String userId){
    return myStore.collection("users").doc(userId).collection("posts").snapshots();
  }

  static Future<DocumentSnapshot?> getUserPhoto(String userId) async {
    late String s;
    return await myStore.collection("users").doc("$userId").get();
  }

  static Future<String?> getUserName(dynamic userId) async {
    late String s;
    await myStore.collection("users").doc("$userId").get().then((value) { s = value.get("name");});
    return s ?? "zaa";
  }

  static Future<Map<String, dynamic>?> getUser(String userId) async {
    return await myStore.collection("users").doc(userId).get().then((value) =>  value.data());
  }
  
  static Future<void> addToFollowings (myUser theUser) async {
    myStore.collection("users").doc(AuthService.getCurrentUser()!.uid.toString()).collection("followings").doc().set(theUser.toJson());
    myStore.collection("users").doc(theUser.userId).update({"follower": 1});
    myStore.collection("users").doc(AuthService.getCurrentUser()!.uid.toString()).update({"following": 1});

  }

  static Stream<QuerySnapshot> getUserFollowings(String userId){
    return myStore.collection("users").doc(userId).collection("followings").snapshots();
  }

  static Future<void> updateUserInfo(String userId, String name, String nick, bool privacy, String url, String newPass) async{
    await myStore.collection("users").doc(userId).update({
      "name": name,
      "nick": nick,
      "imageUrl": url,
      "private": privacy,
    });
    await AuthService.getCurrentUser()!.updatePassword(newPass);

  }

  static Future<void> updatePostInfo(String postDate, String userId, int likes) async {
    await myStore.collection("users").doc(userId).collection("posts").doc("${userId}${postDate}").update({
      "likes": likes,
    });
  }

  static void deletePost(String userId,String postId){
    myStore.collection("users").doc(userId).collection("posts").doc("${userId}${postId}").delete();
  }
  static Future<void> deleteAccount(String userId) async {
    await myStore.collection("users").doc(userId).delete();
  }

  static Future<void> addComment(String userId, String postId, String comment) async {
    await myStore.collection("users").doc(userId).collection("posts").doc(postId).collection("comments").add(
        {"comment": comment});
  }

  static Future<void> sendNotification(String senderId, String receiverId, String message) async {
     await myStore.collection("users").doc(receiverId).collection("notifications").add({
      'sender': senderId as String,
      'message': message as String,
       'date': DateTime.now().toString() as String,
    });
  }
}