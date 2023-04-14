import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/dimensions.dart';
import 'package:deneme/util/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:deneme/util/analytics.dart';

import '../firebase/firebase_analytics.dart';
import '../firebase/firebase_auth.dart';
import '../firebase/firebase_store.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

  static const String routeName = '/signup';
}

class _SignUpState extends State<SignUp> {
  int createCounter = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _surnamecontroller = new TextEditingController();
  TextEditingController _nickcontroller = new TextEditingController();


  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if(isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: alertBoxTexts),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, style: alertBoxTexts),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }

        });
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService.deliverScreen(SignUp.routeName);
    final auth = FirebaseAuth.instance;
    return GestureDetector(onTap: (){FocusScope.of(context).requestFocus(new FocusNode());
    },child: Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp',
          style: appBarTexts,
        ),
        backgroundColor: AppColors.appBarBackground,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: Dimen.regularPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  ' FOODLY ',
                  style: kLogoStyle
              ),
              Text(
                  ' Join FOODLY now ! ',
                  style: secondaryHeaders
              ),

              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Container(
                      width: 150,
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                           Text('Name', style: textFieldTexts,),
                        ],
                      ),
                    ),
                    fillColor: AppColors.logInTextBackground,
                    filled: true,
                    labelStyle: textFieldTexts,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave name empty';
                      }
                    }
                  },
                  controller: _namecontroller,
                ),
              ),

              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Container(
                      width: 150,
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                           Text('Surname', style: textFieldTexts,),
                        ],
                      ),
                    ),
                    fillColor: AppColors.logInTextBackground,
                    filled: true,
                    labelStyle: kLogoStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave surname empty';
                      }
                    }
                  },
                  controller: _surnamecontroller,
                ),
              ),

              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Container(
                      width: 150,
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          Text('Nick', style: textFieldTexts,),
                        ],
                      ),
                    ),
                    fillColor: AppColors.logInTextBackground,
                    filled: true,
                    labelStyle: textFieldTexts,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave nick empty';
                      }
                    }
                  },
                  controller: _nickcontroller,
                ),
              ),

              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Container(
                      width: 100,
                      child: Row(
                        children: [
                          const Icon(Icons.email, color: AppColors.textFieldTexts,),
                          const SizedBox(width: 4),
                           Text('Email', style: textFieldTexts,),
                        ],
                      ),
                    ),
                    fillColor: AppColors.logInTextBackground,
                    filled: true,
                    labelStyle: kLogoStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave e-mail empty';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid e-mail address';
                      }
                    }
                  },
                  controller: _emailcontroller,

                ),
              ),

              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Container(
                      width: 150,
                      child: Row(
                        children: [
                          const Icon(Icons.password, color: AppColors.textFieldTexts,),
                          const SizedBox(width: 4),
                           Text('Password',style: textFieldTexts,),
                        ],
                      ),
                    ),
                    fillColor: AppColors.logInTextBackground,
                    filled: true,
                    labelStyle: kLogoStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave password empty';
                      }
                      if (value.length < 6) {
                        return 'Password too short';
                      }
                    }
                  },
                  controller: _passwordcontroller,

                ),
              ),


              OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await AuthService.signUp(_emailcontroller.text, _passwordcontroller.text);
                    StoreService.addUser(AuthService.getCurrentUser(), myUser(name: _namecontroller.text, surname: _surnamecontroller.text, nick: _nickcontroller.text , follower: 0, following: 0, imageUrl: "https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg", userId: AuthService.getCurrentUser()!.uid.toString(),private: false));
                    Navigator.pushReplacementNamed(context, "/login");
                  } else {
                    _showDialog('Form Error', 'Your form is invalid');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Create',
                    style: buttonTexts,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
              ),
              /*Container(
                child: Row(
                  children: [
                    const SizedBox(width: 40),
                  ]
                ),
              ),*/
              SizedBox(height: 4),
            ],
          ),
        ),
      ),)
    ));
  }
}
