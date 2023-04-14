import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/ui/post_view.dart';
import 'package:deneme/model/post.dart';

class Postcard extends StatelessWidget {

  final Post post;

  Postcard({required this.post});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      // Ekranın kenarlarına olan mesafe
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: FutureBuilder(
                            future: StoreService.getUserPhoto("${post.userId}"),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot){
                              print("burda");
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
                    )
                ),
                SizedBox(
                  width: 10.0,
                ),
                FutureBuilder(
                  future: StoreService.getUserName(post.userId),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case (ConnectionState.waiting):
                        return CircularProgressIndicator();
                      case(ConnectionState.done):
                        return Text(snapshot.data as String ?? "asdsad", style: postUserName,);
                      default:
                        return Container(color: Colors.black);
                    }}
                ),
              ],
            ),

            Padding(
                padding: const EdgeInsets.all(8),
                      child: FlatButton(
                        onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => PostView(p: post)));},
                        child:Image.network(post.imageUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Icon(
                        Icons.favorite,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(
                        Icons.comment,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.share),
                    ],
                  ),
                  Icon(Icons.bookmark)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}