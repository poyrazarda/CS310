import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/firebase/firebase_auth.dart';
import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/model/user.dart';
import 'package:deneme/routes/edit_profile.dart';
import 'package:deneme/ui/user_card.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/ui/post_view.dart';
import 'package:deneme/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deneme/model/post.dart';
import 'package:deneme/ui/post_view.dart';
import 'package:deneme/ui/navBar.dart';
import 'package:deneme/util/analytics.dart';



class ProfileView extends StatefulWidget {
  late myUser theUser;
  ProfileView({Key? key, required this.theUser}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
  static const String routeName = "/profile";
}

class _ProfileViewState extends State<ProfileView> {

  late int many ;

  User? user = FirebaseAuth.instance.currentUser;
   DocumentSnapshot? col;
  void getUserData()async{
    col = await FirebaseFirestore.instance.collection("users").doc("HGzjBHik5HgYaXttsOoyWVTm8rv1").get();
  }
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context)
  {
    FireAnalytics.setAnalyticsScreen(ProfileView.routeName);
    getUserData();
    return Scaffold(
      appBar: AppBar(title: Text("Profile", style: appBarTexts,), backgroundColor: AppColors.appBarBackground,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                   CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: FutureBuilder(
                            future: StoreService.getUserPhoto("${widget.theUser.userId}"),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child:
                Column(
                children: [
                FutureBuilder(
                future: StoreService.getUserName(widget.theUser.userId),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case (ConnectionState.waiting):
                        return CircularProgressIndicator();
                      case(ConnectionState.done):
                        return Text(snapshot.data as String ?? "asdsad", style: profileUserName,);
                      default:
                        return Container(color: Colors.black);
                    }}
              ),
                  FutureBuilder(
                      future: StoreService.getUserName(widget.theUser.userId),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          case (ConnectionState.waiting):
                            return CircularProgressIndicator();
                          case(ConnectionState.done):
                            return Text(snapshot.data as String ?? "asdsad", style: profileUserName,);
                          default:
                            return Container(color: Colors.black);
                        }}
                  ),
                ],
              ),
              ),
              Column(
                children: [
                  if(widget.theUser.userId != AuthService.getCurrentUser()!.uid)...[
                  OutlinedButton(onPressed: () async {
                    await StoreService.sendNotification(AuthService.getCurrentUser()!.uid, widget.theUser!.userId, "has started to follow you!");
                    await StoreService.addToFollowings(widget.theUser);
                    setState((){
                      widget.theUser.follower++;
                    });},
                      child: Text("Follow")),
                  OutlinedButton(onPressed: (){}, child: Text("Chat")),]
                  else...[
                  OutlinedButton(onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfile(theUser: widget.theUser,)));}, child: Text("Edit")),]
                ],
              )
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${widget.theUser.follower} Followers", style: profileSecondaryTexts,),
              Text("${widget.theUser.following} Following", style: profileSecondaryTexts)
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: TextButton(
                      child: Text("Posts", style: profileColumns,),
                      onPressed: (){
                        setState((){
                          buttonPressed = true;
                        });
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: buttonPressed == true ? Colors.black38 : Colors.white,
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: TextButton(
                      child: Text("Followings", style: profileColumns,),
                      onPressed: (){
                        setState((){
                        buttonPressed = false;
                        }
                        );
                    },
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: buttonPressed == false ? Colors.black38 : Colors.white,
                        width: 4,
                      ),
                    ),
                  ),
              ),

              ),
            ],
          ),
          SizedBox(height: 16,),
          if (buttonPressed == true && !widget.theUser.private) ...[
            StreamBuilder(
        stream: StoreService.getPosts(widget.theUser.userId),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(direction:Axis.horizontal,children:
                    snapshot.data!.docs.map((e) => SizedBox(height:125, width:125,child: IconButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => PostView(p: Post.fromJson(e.data() as Map<String, dynamic>))));
                    }, icon: Image.network(e.get("imageUrl"))))).toList()
              ),
                  ),
                );
            })
          ]
          else if (buttonPressed == false && !widget.theUser.private)...[StreamBuilder(stream: StoreService.getUserFollowings(widget.theUser.userId),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else
              return Expanded(
              child: ListView(children:
              snapshot.data!.docs.map((e) => UserCard(theUser: myUser.fromJson(e.data() as Map<String, dynamic>))).toList() ?? [Container(color: Colors.green,)],),
            );
          }

          )]
          else ...[SizedBox(height: 32,),Text("User profile is private !", style: buttonTexts,)],

        ],
      ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}