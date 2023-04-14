import 'package:flutter/material.dart';
import 'package:deneme/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle? kLogoStyle = GoogleFonts.smooch( //foodly logosu style
  color: AppColors.logoColor,
  fontWeight: FontWeight.w900,
  fontSize: 60.0,
  letterSpacing: -0.7,
);

TextStyle? appBarTexts = GoogleFonts.robotoSlab( //foodly logosu style
  color: AppColors.appBarTexts,
  fontWeight: FontWeight.w900,
  fontSize: 16.0,
  letterSpacing: 0.3,
);

final textFieldTexts = GoogleFonts.robotoSlab( //follower ve following sayıları için
  color: AppColors.textFieldTexts,
  fontSize: 24.0,
  letterSpacing: -0.9,
  fontWeight: FontWeight.w400
);

final buttonTexts = GoogleFonts.roboto( //Foto altına comment için
  color: AppColors.buttonTexts,
  fontWeight: FontWeight.w900,
  fontSize: 35.0,
  letterSpacing: -0.7,
);

final alertBoxTexts = GoogleFonts.montserrat( //Login bölümünde kullanıcı bilgileri için ve welcome page yazıları için
  color: AppColors.logInTextBackground,
  fontSize: 36.0,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.7,
);

final secondaryHeaders = GoogleFonts.smooch( // add post kısmındaki bilgiler için
  fontSize: 30.0,
  color: AppColors.logoColor,
  fontWeight: FontWeight.w600,
);

final postUserName = GoogleFonts.montserrat(  // collection başlıkları için
  fontSize: 12.0,
  color: Colors.black,
  fontWeight: FontWeight.bold
);

final notificationTexts = GoogleFonts.roboto( //Search Page'deki yazı için
  color: Colors.black,
  fontSize: 15.0,
  letterSpacing: -0.7,
  fontWeight: FontWeight.bold
);

final notificationTime = GoogleFonts.roboto( //Search Page'deki yazı için
    color: Colors.black,
    fontSize: 12.0,
    letterSpacing: -0.7,
    fontWeight: FontWeight.bold
);

final profileUserName = GoogleFonts.montserrat(  // collection başlıkları için
    fontSize: 24.0,
    color: Colors.black,
    fontWeight: FontWeight.bold
);

final profileSecondaryTexts = GoogleFonts.montserrat(  // collection başlıkları için
    fontSize: 14.0,
    color: Colors.black,
    fontWeight: FontWeight.w400
);

final profileColumns = GoogleFonts.montserrat(  // collection başlıkları için
    fontSize: 14.0,
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold
);

final postHeader = GoogleFonts.montserrat(  // collection başlıkları için
    fontSize: 28.0,
    color: Colors.black,
    fontWeight: FontWeight.bold
);

final postComments = GoogleFonts.montserrat(  // collection başlıkları için
    fontSize: 18.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
);