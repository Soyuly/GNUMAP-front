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
        margin: const EdgeInsets.fromLTRB(13, 0, 0, 0),
        child: Column(
          children: const [SizedBox(
            height: 35,
            child: SearchBar()
          ),
        SizedBox(
            height: 100,
            child: History()
        ),]
        ),
      ),

    );
  }
}
class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
      child: CupertinoSearchTextField(decoration: BoxDecoration(
          color: Color.fromRGBO(188, 188, 188, 0.54),
          borderRadius: BorderRadius.circular(10)
      ),),
    );
  }
}

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 7, 0, 0),
      child: ListView(
        children: const [Text('History', style: TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(0, 16, 72, 0.6),
          fontFamily: 'AppleSDGothicNeo',
          fontWeight: FontWeight.bold
        ),),
          Text('History', style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(0, 16, 72, 0.6),
              fontFamily: 'AppleSDGothicNeo',
              fontWeight: FontWeight.bold
          ),)

        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

