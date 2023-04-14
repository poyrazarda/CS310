import 'package:deneme/util/colors.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
class WalkthroughView extends StatefulWidget{
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<WalkthroughView>{

  PageController pageController = PageController();
  int pageCount = 0;


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Walkthrough", style: appBarTexts,), backgroundColor: AppColors.appBarBackground,),
      body: PageView(
        onPageChanged: (index){ pageCount = index;},
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          controller: pageController,
          children: [
            Column(children: [Expanded(child: Image.asset("lib/assets/welcome.png"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/signup.jpeg"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/login.png"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/feed.jpeg"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/profile_post.png"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/profile_collections.jpeg"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/post_view.png"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/search.png"),),]),
            Column(children: [Expanded(child: Image.asset("lib/assets/notification.jpeg"),),]),

          ]),
      bottomNavigationBar: Row(
        children: [
          IconButton(onPressed: (){if(pageCount >= 1)pageController.animateToPage(--pageCount, duration: Duration(milliseconds: 250), curve: Curves.bounceIn);}, icon: Icon(Icons.navigate_before)),
          Spacer(),
          IconButton(onPressed: (){
            if(pageCount <= 7)pageController.animateToPage(++pageCount, duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
            else Navigator.pushReplacementNamed(context, "/welcome");}, icon: Icon(Icons.navigate_next)),
        ],
      ),
    );
  }
}