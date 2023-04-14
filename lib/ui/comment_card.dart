import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class CommentCard extends StatefulWidget{

  String comment;
  String userId;
  String date;

  CommentCard({required this.comment, required this.userId, required this.date});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard>{

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [

          Text(widget.comment, style: profileSecondaryTexts,),
          Spacer(),
          Text(widget.date),

        ],
      ),
    );
  }
}