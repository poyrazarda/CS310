import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:deneme/util/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deneme/util/analytics.dart';

import '../firebase/firebase_auth.dart';
import '../firebase/firebase_storage.dart';
import '../firebase/firebase_store.dart';
import 'package:deneme/model/post.dart';

class AddPost extends StatefulWidget{
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
  static const String routeName = "/addpost";

}

class _AddPostState extends State<AddPost>{

  late String? url;
  TextEditingController _header = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context){
    FireAnalytics.setAnalyticsScreen(AddPost.routeName);
    return GestureDetector(onTap: (){
      FocusScope.of(context).requestFocus(new FocusNode());
    },
      child: Scaffold(
        appBar: AppBar(title: Text("Adding new Post"), centerTitle: true,),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
              controller: _header,
            decoration: InputDecoration(
                label: Text("Header", style: textFieldTexts,),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mainBackground,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),

          ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(
                  label: Text("Description", style: textFieldTexts,),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.mainBackground,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

              ),
              SizedBox(height: 16,),
              (_image == null) ? IconButton(onPressed: () async{
                _image = await _picker.pickImage(source: ImageSource.gallery);
                setState((){});
              }, icon: Icon(Icons.add_a_photo_outlined), iconSize: 128,)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(16),child: Image.file(File(_image!.path),))),
                    SizedBox(width: 8,),
                    Column(children: [
                      ElevatedButton(onPressed: () async {await StorageService.uploadImage(File(_image!.path), AuthService.getCurrentUser()!).then((value) => url = value);}, child: Text("Upload Image")),
                      ElevatedButton(onPressed: (){setState((){_image = null;});}, child: Text("Cancel"))],)
                ]
                ),
              Row(children: [Expanded(child: ElevatedButton(onPressed: () async { await StoreService.addPosttoUser(AuthService.getCurrentUser(), Post(header: _header.text, description:_description.text, likes: 0, user: AuthService.getCurrentUser().toString(), imageUrl: url!, userId: AuthService.getCurrentUser()!.uid,date: DateTime.now().toString() ));}, child: Text("Post Now !"),))],)
              ]
          ),
        ),
      ),
    );
  }
}