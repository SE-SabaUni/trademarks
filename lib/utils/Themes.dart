import 'dart:ui';

import 'package:flutter/material.dart';

class Themes {
  static ThemeData LightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
        //for app bar
        headline1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'IBMPlexSansArabic',
            fontWeight: FontWeight.bold),
        //for
        headline2: TextStyle(
            color: Colors.white, fontFamily: 'IBMPlexSansArabic', fontSize: 13),
        //for drawer
        headline3: TextStyle(
            color: Colors.white, fontFamily: 'IBMPlexSansArabic', fontSize: 17),
        // for login headline
        headline4: TextStyle(
            color: Color(0xff383232),
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 16),

        //for body
        headline5: TextStyle(
            color: Colors.black, fontFamily: 'IBMPlexSansArabic', fontSize: 15),
        headline6: TextStyle(
            color: Color(0xff7F7671),
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 15),

        //for hint
        bodyText1: TextStyle(
          color: Color(0xff7F7671),
          fontFamily: 'IBMPlexSansArabic',
          fontSize: 12,
        ),

        //for buttons
        bodyText2: TextStyle(
          color: Color(0xfff7f2e8),
          fontFamily: 'IBMPlexSansArabic',
          fontSize: 12,
        ),
        subtitle1: TextStyle(
          color: Color(0xff7F7671),
        )),
    ////////////////////
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Color(0xff7F7671)),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          width: 5,
        ), //<-- SEE HERE
        borderRadius: BorderRadius.circular(50.0),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(width: 5, color: Color(0xff383232)),
      ),
      prefixIconColor: Color(0xff383232),
    ),
    ////////////////////
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Color(0xff383232),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xff383232),
    ),
  );

  ////////////////////////////////////////////////////

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Color(0xff383232),
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 20),
        headline5: TextStyle(
            color: Color(0xff383232),
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 17),
        bodyText1: TextStyle(
          color: Color(0xffA89B93),
          fontFamily: 'IBMPlexSansArabic',
          fontSize: 15,
        ),
        bodyText2: TextStyle(
          color: Color(0xffA89B93),
          fontFamily: 'IBMPlexSansArabic',
          fontSize: 15,
        )),
    /////////////////////// for textFormField

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Color(0xff383232)),
      hintStyle: const TextStyle(color: Color(0xff7F7671)),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          width: 5,
        ), //<-- SEE HERE
        borderRadius: BorderRadius.circular(50.0),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(width: 5, color: Color(0xff383232)),
      ),
      prefixIconColor: Color(0xffA89B93),
    ),

    ///////////////////////////
    scaffoldBackgroundColor: Color.fromARGB(255, 77, 69, 69),
    iconTheme: const IconThemeData(
      color: Color(0xffA89B93),
    ),
    /////////////////////
    appBarTheme: const AppBarTheme(
      color: Color(0xff383232),
    ),
  );
}
