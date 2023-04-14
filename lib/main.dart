import 'package:deneme/model/user.dart';
import 'package:deneme/routes/add_post.dart';
import 'package:deneme/util/analytics.dart';
import 'package:deneme/routes/profile.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/routes/walkthrough_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deneme/routes/search_view.dart';
import 'package:deneme/ui/post_view.dart';
import 'package:deneme/routes/welcomepage.dart';
import 'package:deneme/routes/loginpage.dart';
import 'package:deneme/routes/signuppage.dart';
import 'package:deneme/routes/feed_view.dart';
import 'package:deneme/routes/notification_view.dart';
import 'package:deneme/routes/walkthrough_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:deneme/util/authentication_service.dart';
import 'package:deneme/util/analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{

  int? firstTime;
  SharedPreferences? prefs;

  Future<void> firstRun() async{
    prefs = await SharedPreferences.getInstance();
    firstTime = prefs?.getInt("appFirstTime") ?? 0;
  }

  @override
  void initState() {
    super.initState();
    firstRun();
}

  @override
  Widget build(BuildContext context){
    if (firstTime == 0){
      firstTime = 1;
      prefs!.setInt("appFirstTime", firstTime!);
    return MaterialApp(
        routes: {
          "/": (context) => WalkthroughView(),
          Welcome.routeName: (context) => Welcome(),
          ProfileView.routeName: (context) => ProfileView(theUser: myUser(name: "",surname: "",nick: "",follower:0,following:0,imageUrl: "",userId: "",private: false)),
          SearchView.routeName: (context) => SearchView(),
          PostView.routeName: (context) => PostView(p: null),
          FeedView.routeName: (context) => FeedView(),
          Login.routeName: (context) => Login(),
          SignUp.routeName: (context) => SignUp(),
          NotificationView.routeName: (context) => NotificationView(),
          AddPost.routeName: (context) => AddPost(),

        },
      );}
    else if (firstTime == 1){
      return MaterialApp(
        home: Welcome(),
        routes: {
          Welcome.routeName: (context) => Welcome(),
          ProfileView.routeName: (context) => ProfileView(theUser: myUser(name: "",surname: "",nick: "",follower:0,following:0,imageUrl: "",userId: "",private: false),),
          SearchView.routeName: (context) => SearchView(),
          PostView.routeName: (context) => PostView(p: null),
          FeedView.routeName: (context) => FeedView(),
          Login.routeName: (context) => Login(),
          SignUp.routeName: (context) => SignUp(),
          NotificationView.routeName: (context) => NotificationView(),
          AddPost.routeName: (context) => AddPost(),
        },
      );
    }
    else{return Center(child: CircularProgressIndicator());}
  }
}



