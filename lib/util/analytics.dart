import 'package:firebase_analytics/firebase_analytics.dart';

class FireAnalytics {

  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> setAnalyticsScreen(String scName) async {
    await FirebaseAnalytics.instance
        .setCurrentScreen(
        screenName: scName
    );}

  static Future<void> setAnalyticsUserId(String userId) async {
    await FirebaseAnalytics.instance
        .setUserId(
        id: userId
    );}
}