import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_auth.dart';
import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/model/notification.dart';
import 'package:deneme/ui/notification_card.dart';
import 'package:deneme/ui/navBar.dart';
import 'package:deneme/util/analytics.dart';



class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
  static const String routeName = "/notification";

}

class _NotificationViewState extends State<NotificationView> {
  

  @override
  Widget build(BuildContext context) {
    FireAnalytics.setAnalyticsScreen(NotificationView.routeName);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Notifications',
          style: appBarTexts
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarBackground,
        elevation: 20.0,
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: StreamBuilder(stream: StoreService.myStore.collection("users").doc(AuthService.getCurrentUser()!.uid).collection("notifications").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              return ListView(
                children: snapshot.data!.docs.map((e) => NotificationCard(senderId: e.get("sender"), message: e.get("message"), date: e.get("date"))).toList(),
              );
                }),
          )
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}