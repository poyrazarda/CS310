import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/model/user.dart';
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

class EditProfile extends StatefulWidget{
  myUser theUser;
  EditProfile({Key? key, required this.theUser}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
  static const String routeName = "/addpost";

}

class _EditProfileState extends State<EditProfile>{

  bool? latest;
  late String? url;
  TextEditingController _name = new TextEditingController();
  TextEditingController _nick = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context){
    FireAnalytics.setAnalyticsScreen(EditProfile.routeName);
    return GestureDetector(onTap: (){
      FocusScope.of(context).requestFocus(new FocusNode());
    },
      child: Scaffold(
        appBar: AppBar(title: Text("Edit Profile"), centerTitle: true,),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    label: Text("Name", style: textFieldTexts,),
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
                  controller: _nick,
                  decoration: InputDecoration(
                    label: Text("Nick", style: textFieldTexts,),
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
                  controller: _pass,
                  decoration: InputDecoration(
                    label: Text("New Password", style: textFieldTexts,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text("Public/Private", style: profileUserName,),
                    Switch.adaptive(value: latest ?? false, onChanged: (value){
                      setState((){
                        latest = value;
                      });
                    }),
                  ],
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
                Row(children: [Expanded(child: ElevatedButton(onPressed: () async { await StoreService.updateUserInfo(widget.theUser.userId, _name.text, _nick.text,latest ?? false, url ??
                    "https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg", _pass.text); Navigator.pop(context);}, child: Text("Edit Now !"),))],),

                Row(children: [Expanded(child: ElevatedButton(onPressed: () async { await StoreService.deleteAccount(AuthService.getCurrentUser()!.uid); await AuthService.getCurrentUser()!.delete();Navigator.pushNamedAndRemoveUntil(context, "/welcome", (route) => false);},style: ElevatedButton.styleFrom(primary: Colors.red) ,child: Text("Delete Account"),))],)
              ]
          ),
        ),
      ),
    );
  }
}