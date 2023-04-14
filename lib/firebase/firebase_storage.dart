import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/post.dart';

class StorageService {

  static FirebaseStorage myStorage = FirebaseStorage.instance;

  static Future<String?> uploadImage(File file, User user) async {
    Reference ref = myStorage.ref("posts").child("${user.uid}${DateTime.now().toString()}");
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}