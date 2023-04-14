import 'dart:io' show Platform;

import 'package:deneme/routes/signuppage.dart';
import 'package:deneme/util/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/dimensions.dart';
import 'package:deneme/util/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deneme/firebase/firebase_analytics.dart';

import '../firebase/firebase_analytics.dart';
import '../firebase/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  static const String routeName = '/login';
}

class _LoginState extends State<Login> {
  int loginCounter = 0;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';

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
    AnalyticsService.deliverScreen(Login.routeName);
    final auth = FirebaseAuth.instance;

    return GestureDetector(onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},child:Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: appBarTexts,
        ),
        backgroundColor: AppColors.appBarBackground,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '   Member login:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              ),
              Container(
                padding: EdgeInsets.all(5),
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
                    labelStyle: textFieldTexts,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainBackground,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if(value != null){
                      if(value.isEmpty) {
                        return 'Cannot leave e-mail empty';
                      }
                      if(!EmailValidator.validate(value)) {
                        return 'Please enter a valid e-mail address';
                      }
                    }
                  },
                  onSaved: (value) {
                    email = value ?? '';
                  },
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
                           Text('Password', style: textFieldTexts,),
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
                    if(value != null){
                      if(value.isEmpty) {
                        return 'Cannot leave password empty';
                      }
                      if(value.length < 6) {
                        return 'Password too short';
                      }
                    }
                  },
                  onSaved: (value) {
                    pass = value ?? '';
                  },
                ),
              ),

              OutlinedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    dynamic res = await AuthService.logIn(email,pass);
                    if( res is UserCredential)
                      Navigator.pushReplacementNamed(context, "/feed");
                    else
                      _showDialog("Log in Error", res);

                  } else {
                    _showDialog('Form Error', 'Your form is invalid');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Login',
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

              OutlinedButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in with Facebook',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight : FontWeight.w600,
                        color: Colors.black,
                      )
                    ),
                    const Icon(
                      Icons.facebook,
                      size: 20,
                      color: Colors.black,
                    )
                  ]
                  )
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
              ),
              SizedBox(height: 4),

              OutlinedButton(
                onPressed: () async {
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                  final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
                  auth.signInWithCredential(credential);},
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log in with Google',
                          style: const TextStyle(
                            fontSize:15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )
                        ),
                        const Icon(
                          Icons.mail,
                          size:20,
                          color: Colors.black,
                        )
                      ]
                    )
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}