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
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20, color: Colors.white, fontFamily: 'Pretendard'),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontFamily: 'Pretendard'),
      headline4: TextStyle(
          fontSize: 13, color: Colors.white, fontFamily: 'Pretendard'),
      headline5: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: 'Pretendard',
      ),
      headline6: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
          fontSize: 18, color: Colors.white, fontFamily: 'Pretendard')),
  brightness: Brightness.dark,
);
