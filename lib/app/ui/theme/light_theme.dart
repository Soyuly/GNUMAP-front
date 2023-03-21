import 'package:flutter/material.dart';

var lightThemeData = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black)),
  primaryColor: Color.fromRGBO(0, 16, 72, 0.6),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(13, 13, 16, 0.69),
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 16, 72, 0.6),
          fontFamily: 'Pretendard'),
      headline3: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 16, 72, 0.6),
          fontFamily: 'Pretendard'),
      headline4: TextStyle(
          fontSize: 13, color: Colors.black, fontFamily: 'Pretendard'),
      headline5: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(0, 16, 72, 0.6),
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(0, 16, 72, 0.6),
        fontFamily: 'Pretendard',
      ),
      headline6: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(0, 122, 255, 1),
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
          fontSize: 18, color: Colors.black, fontFamily: 'Pretendard')),
  brightness: Brightness.light,
);
