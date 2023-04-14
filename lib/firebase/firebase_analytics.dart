import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsService{

  static FirebaseAnalytics myAnalytics = FirebaseAnalytics.instance;

  static void deliverScreen(String viewName){
    myAnalytics.setCurrentScreen(screenName: viewName);
  }

  static void deliverUser(User? user){
    myAnalytics.setUserId(id: user?.uid);
  }
}