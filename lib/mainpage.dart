import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(

          margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('그누맵',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(13, 13, 16, 0.69),
                    fontFamily: 'AppleSDGothicNeo',
                    fontWeight: FontWeight.bold,
                  )),
              Icon(
                  Icons.settings,
                  color : Color.fromRGBO(13, 13, 16, 0.69))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(13, 10, 13, 0),
        child: CupertinoSearchTextField(decoration: BoxDecoration(
          color: Color.fromRGBO(188, 188, 188, 0.54),
            borderRadius: BorderRadius.circular(10)
        ),),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
