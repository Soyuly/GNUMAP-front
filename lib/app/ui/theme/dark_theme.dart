import 'package:flutter/material.dart';

var darkThemeData = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white)),
  primaryColor: Colors.white,
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'AppleSDGothicNeo',
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20, color: Colors.white, fontFamily: 'AppleSDGothicNeo'),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontFamily: 'AppleSDGothicNeo'),
      headline4: TextStyle(
          fontSize: 13, color: Colors.white, fontFamily: 'AppleSDGothicNeo'),
      headline5: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'AppleSDGothicNeo',
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: 'AppleSDGothicNeo',
          fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: 'AppleSDGothicNeo',
      ),
      headline6: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'AppleSDGothicNeo',
          fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
          fontSize: 18, color: Colors.white, fontFamily: 'AppleSDGothicNeo')),
  brightness: Brightness.dark,
);
