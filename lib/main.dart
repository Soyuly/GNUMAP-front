import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("편의점")),
        ),
        body: Convenience(),

      ),
    );
  }
}

class Convenience extends StatefulWidget {
  const Convenience({Key? key}) : super(key: key);

  @override
  State<Convenience> createState() => _ConvenienceState();
}

class _ConvenienceState extends State<Convenience> {
  List<dynamic> convenience = [
    "지점명: CU 느티마루점",
    "지점명: CU 느티마루점",
    "지점명: CU 느티마루점",
    "지점명: CU 느티마루점",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 ",
    "지점명: CU 느티마루점 "
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      itemCount: convenience.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // color: Colors.amber[colorCodes[index]],
          child: Center(child: Text(convenience[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}





