import 'package:deneme/model/user.dart';
import 'package:deneme/routes/profile.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_auth.dart';
import '../firebase/firebase_store.dart';

class NavBar extends StatelessWidget{
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      height: 50.0,
      alignment: Alignment.center,
      child: new BottomAppBar(
        child: new Row(
          // alignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: (){Navigator.pushNamed(context, "/feed");},
            ),
            new IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: (){Navigator.pushNamed(context, "/search");},
            ),

            new IconButton(
              icon: Icon(
                Icons.notifications,
              ),
              onPressed: (){Navigator.pushNamed(context, "/notification");},
            ),
            new IconButton(
              icon: Icon(
                Icons.account_box,
              ),
              onPressed: () async {
                Map<String, dynamic>? myid = await StoreService.getUser(AuthService.getCurrentUser()!.uid.toString());
                Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileView(theUser: myUser.fromJson(myid!),)));},
            ),
            new IconButton(
              icon: Icon(
                Icons.time_to_leave,
              ),
              onPressed: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                AuthService.signOut();
                },
            ),
          ],
        ),
      ),
    );
  }
}