import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/model/notification.dart';

import '../firebase/firebase_store.dart';

class NotificationCard extends StatelessWidget {

  String senderId;
  String message;
  String date;

  NotificationCard({required this.senderId, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
             Padding(
               padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: FutureBuilder(
                          future: StoreService.getUserPhoto(senderId),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting)
                              return Container(color: Colors.green,);
                            if (snapshot.connectionState == ConnectionState.done)
                              return Image.network( snapshot.data!.get("imageUrl") as String ?? "https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg",
                                fit: BoxFit.fitHeight,);
                            else
                              return Container(color: Colors.pink,);
                          }
                      ),
                    )
                ),
             ),

             const SizedBox(width: 5),

             Padding(
              padding: const EdgeInsets.all(0),
              child: Flexible(
                   child: FutureBuilder(
                     future: StoreService.myStore.collection("users").doc(senderId).get(),
                     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot){
                       if (snapshot.connectionState == ConnectionState.waiting)
                         return Container(color: Colors.green,);
                       if (snapshot.connectionState == ConnectionState.done)
                         return Text("${snapshot.data!.get("name")} $message", style: notificationTexts,);
                       else
                         return Container(color: Colors.pink,);
                     },
                   ),
                 ),

              ),

             const Spacer(),

             Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Text(
                    DateTime.now().difference(DateTime.parse(date)).inMinutes.toString(),
                    style: notificationTime
                    ,
                  ),
                  Text("mins ago", style: notificationTime,)
                       ],
                     ),
                   ),
                 ],
               ),
             ],
           ),
        ),
    );
  }
}
