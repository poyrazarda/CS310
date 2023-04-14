import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  static User? user = FirebaseAuth.instance.currentUser;
}