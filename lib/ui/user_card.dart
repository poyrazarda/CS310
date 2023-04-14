import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_auth.dart';
import '../firebase/firebase_store.dart';
import '../model/user.dart';
import '../routes/profile.dart';


class UserCard extends StatefulWidget {

  myUser theUser;

  UserCard({required this.theUser});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard>{

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
                        radius: 23,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(widget.theUser.imageUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                    )
                ),

                const SizedBox(width: 5),

                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Flexible(
                    child: Text("${widget.theUser.name} ${widget.theUser.surname}",
                        overflow: TextOverflow.visible,
                        style: profileSecondaryTexts
                    ),
                  ),

                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () async {
                        Map<String, dynamic>? myid = await StoreService.getUser(widget.theUser.userId);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileView(theUser: myUser.fromJson(myid!),)));
                      }, icon: Icon(Icons.arrow_right))
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