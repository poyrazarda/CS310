import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_auth.dart';
import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/util/authentication_service.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/model/post.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/ui/post_card.dart';
import 'package:deneme/ui/navBar.dart';
import 'package:deneme/util/analytics.dart';

import '../firebase/firebase_analytics.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
  static const String routeName = "/feed";

}

class _FeedViewState extends State<FeedView> {
  int peopleCount = 0;

  @override
  Widget build(BuildContext context) {
    AnalyticsService.deliverScreen(FeedView.routeName);
    AnalyticsService.deliverUser(AuthService.getCurrentUser());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, "/addpost");}, icon: Icon(Icons.add))
        ],
        title: Text('FOODLY', style: appBarTexts,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.appBarBackground,
        shadowColor: AppColors.shadowColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/1.1,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: StoreService.getUserFollowings(AuthService.getCurrentUser()!.uid.toString()),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return ListView(children:
                          snapshot.data!.docs.map<Widget>((f) {
                            return Expanded(
                              child: SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 1.1,
                                child: StreamBuilder(
                                  stream: StoreService.getPosts(
                                      f.get("userId").toString()),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    return SizedBox(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              child: ListView(children:
                                              snapshot.data?.docs.map<Widget>((
                                                  e) {
                                                return Postcard(post: Post(
                                                    header: e.get("header"),
                                                    description: e.get(
                                                        "description"),
                                                    user: e.get("user"),
                                                    imageUrl: e.get("imageUrl"),
                                                    likes: e.get("likes"),
                                                    userId: e.get("userId"),
                                                    date: e.get("date")));
                                              }).toList() ??
                                                  [CircularProgressIndicator()],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList());
                        }),
                    ),
                  )]
                ),
            ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: NavBar(),
    );
  }
}