import 'package:flutter/material.dart';
import 'package:gnumap/mainpage.dart';
import 'package:gnumap/theme_changer.dart';
import 'package:location/location.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        defaultBrightness: Brightness.light,
        debugShowCheckedModeBanner: false,
        builder: (context, _brightness) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: _brightness,
            ),
            home: MainPage(),
          );
        }
    );
  }
}








