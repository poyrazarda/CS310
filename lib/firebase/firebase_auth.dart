
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  static final FirebaseAuth myAuth = FirebaseAuth.instance;


  static User? _userFromFirebase(User? user) {
    return user;
  }

  static User? getCurrentUser(){
    return myAuth.currentUser;
  }

  static Stream<User?> get user {
    return myAuth.authStateChanges().map(_userFromFirebase);
  }

  static Future<dynamic> logIn (String email, String password) async{
    try{
      return await myAuth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  static Future<dynamic>  signUp(String email, String password) async{
    try{
      await myAuth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      print(e);
    }
  }

  static void signOut(){
    myAuth.signOut();
  }
}