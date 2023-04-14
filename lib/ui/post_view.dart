import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_auth.dart';
import 'package:deneme/model/user.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/model/post.dart';

import '../firebase/firebase_store.dart';
import 'comment_card.dart';

class PostView extends StatefulWidget {
  Post? p;
  PostView({Key? key, required this.p}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();

  static const String routeName = "/post";

}

class _PostViewState extends State<PostView>{

  TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _comment.clear();
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.appBarBackground,
        actions: [
          if(AuthService.getCurrentUser()!.uid == widget.p!.userId)
            ElevatedButton(onPressed: (){
              StoreService.deletePost(AuthService.getCurrentUser()!.uid, widget.p!.date);
              Navigator.pop(context);
            }, child: Icon(Icons.cancel))
        ],),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height/1.1,
              width: MediaQuery.of(context).size.width/1.1,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(widget.p!.header, style: postHeader,),

                    Padding(
                      padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                      Expanded(child: Center(child:Image.network(widget.p!.imageUrl)))
                    ],
                    ),),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Center(child:ElevatedButton.icon(onPressed: () async {
                          await StoreService.sendNotification(AuthService.getCurrentUser()!.uid, widget.p!.userId, "has liked your post!");
                          await StoreService.updatePostInfo(widget.p!.date, widget.p!.userId, ++widget.p!.likes);
                          setState((){
                            });}, icon: Icon(Icons.favorite), label: Text("${widget.p!.likes}"), style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(36)),))),
                        SizedBox(width: 16,),
                        Expanded(child: Center(child:ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.comment), label: Text("Comments"),style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(36)),))),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width/1.2,
                        child: StreamBuilder(stream: StoreService.myStore.collection("users").doc(widget.p!.userId).collection("posts").doc("${widget.p!.userId}${widget.p!.date}").collection("comments").snapshots(),
                            builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){
                              return Expanded(child: ListView(
                                scrollDirection: Axis.vertical,
                                children:
                                  snapshot.data!.docs.map<Widget>((e)  {return CommentCard(comment: e.get("comment"), userId: AuthService.getCurrentUser()!.uid, date: "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}");}).toList(),

                              ));
                            }),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextField(controller: _comment,decoration: InputDecoration(suffixIcon: IconButton(onPressed: () async {
                          await StoreService.sendNotification(AuthService.getCurrentUser()!.uid, widget.p!.userId, "has commented to your post!");
                          await StoreService.addComment(widget.p!.userId, "${widget.p!.userId}${widget.p!.date}", _comment.text); _comment.clear();
                        }, icon: Icon(Icons.send)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),borderSide: BorderSide(color: AppColors.mainBackground))),),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}