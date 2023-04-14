import 'package:deneme/firebase/firebase_analytics.dart';
import 'package:deneme/util/analytics.dart';
import 'package:flutter/material.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/dimensions.dart';
import 'package:deneme/util/styles.dart';
import 'package:deneme/util/analytics.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  static const String routeName = "/welcome";


  @override
  Widget build(BuildContext context) {
    AnalyticsService.deliverScreen(routeName);
      return Scaffold(
      appBar: AppBar(
        title:  Text('Welcome',style: appBarTexts,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.appBarBackground,
        shadowColor: AppColors.shadowColor,
      ),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: Dimen.regularPadding,
                child: RichText(
                  text: TextSpan(
                    text: " ",
                    style: kLogoStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: "FOODLY",
                        style: kLogoStyle
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtgiU4lFijwvdCJT6LCpkqeWD80Uy5H-m_eQ&usqp=CAU',),
            ),
            //Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,  "/signup");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'Signup',
                          style: buttonTexts,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                      ),
                    ),
                  ),

                  SizedBox(width: 8.0,),

                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'Login',
                          style: buttonTexts,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}