import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gnumap/CImages.dart';
import 'package:location/location.dart';
import 'package:gnumap/pathInfo.dart';

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
              Icon(Icons.settings, color: Color.fromRGBO(13, 13, 16, 0.69))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(13, 0, 0, 0),
        child: Column(children: [
          Container(child: SearchBar()),
          SizedBox(height: 35, child: History()),
          Container(
              height: 30,
              child:
                  Align(alignment: Alignment.topLeft, child: FavoriteTitle())),
          SizedBox(
            height: 100,
            child: Favorite(),
          ),
          Container(
              height: 40,
              child: Align(
                  alignment: Alignment.topLeft, child: ConvenientTitle())),
          Container(
              margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
              child: ConvenientItems_top()),
          Container(
              margin: EdgeInsets.fromLTRB(5, 0, 15, 10),
              child: ConvenientItems_bottom()),
          Container(
              height: 35,
              margin: EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: Align(alignment: Alignment.topLeft, child: GnumapTitle())),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 15, 10),
            height: 130,
            child: Minimap(),
          )
        ]),
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
      child: CupertinoSearchTextField(
        itemSize: 20,
        decoration: BoxDecoration(
            color: Color.fromRGBO(188, 188, 188, 0.54),
            borderRadius: BorderRadius.circular(10)),
        onSubmitted: (name) async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PathInfo()),
          );
        },
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> histories = <String>['30동', '컴퓨터과학관', '24동', '경상대교양학관'];
    return Container(
      margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: histories.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
              child: Text(histories[index],
                  style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(0, 16, 72, 0.6),
                      fontFamily: 'AppleSDGothicNeo')),
            );
          }),
    );
  }
}

class FavoriteTitle extends StatelessWidget {
  const FavoriteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
      child: Text('즐겨찾기',
          style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(0, 16, 72, 0.6),
              fontFamily: 'AppleSDGothicNeo')),
    );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final List<String> favoriteItems = <String>['도서관', '박물관', '컴퓨터과학관', '교양학관'];
    final List<String> favoriteIndex = <String>['1동', '', '30동', '24동'];
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: favoriteItems.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 70,
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cs.jpg')),
                      borderRadius: BorderRadius.circular(50),
                    )),
              );
            }));
  }
}

class ConvenientTitle extends StatelessWidget {
  const ConvenientTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
      child: Text('편의시설',
          style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(0, 16, 72, 0.6),
              fontFamily: 'AppleSDGothicNeo')),
    );
  }
}

class GnumapTitle extends StatelessWidget {
  const GnumapTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('GNU MAP',
          style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(0, 16, 72, 0.6),
              fontFamily: 'AppleSDGothicNeo')),
      Icon(Icons.arrow_forward_ios_rounded)
    ]);
  }
}

class Minimap extends StatelessWidget {
  const Minimap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/minimap.png')),
          borderRadius: BorderRadius.circular(20),
        ));
  }
}

class Position {

}
