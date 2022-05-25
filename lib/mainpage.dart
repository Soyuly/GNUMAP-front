import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

import 'package:gnumap/CImages.dart';
import 'package:gnumap/gnuMap.dart';
import 'package:gnumap/pathInfo.dart';
import 'package:gnumap/models/db.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List _histories = [];
  final HistoryHelper _historyHelper = HistoryHelper();

  Future _getHistories() async {
    _histories = await _historyHelper.getItems();
    print(_histories);
    return _histories;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _getHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text('그누맵',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(13, 13, 16, 0.69),
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Icon(Icons.settings, color: Color.fromRGBO(13, 13, 16, 0.69))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(13, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              SafeArea(child: SearchBar()),
              SizedBox(
                  height: 35,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
                      child: FutureBuilder(
                          future: _getHistories(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return Container(child: Text('로딩중임'));
                            }
                            //error가 발생하게 될 경우 반환하게 되는 부분
                            else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }
                            // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                            else {
                              print(_histories);
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _histories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: TextButton(
                                        onLongPress: () async {
                                          print('삭제');
                                          await _historyHelper.remove(
                                              _histories[index]['name']);
                                          await _getHistories();
                                        },
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PathInfo(
                                                    name: _histories[index]
                                                        ['name'])),
                                          );
                                        },
                                        child: Text(_histories[index]['name'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    0, 16, 72, 0.6),
                                                fontFamily:
                                                    'AppleSDGothicNeo')),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(10, 30),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.centerLeft),
                                      ),
                                    );
                                  });
                            }
                          }))),
              Container(
                  height: 30,
                  child: Align(
                      alignment: Alignment.topLeft, child: FavoriteTitle())),
              SizedBox(
                height: 100,
                child: Favorite(),
              ),
              Container(
                  height: 40,
                  child: Align(
                      alignment: Alignment.topLeft, child: ConvenientTitle())),
              SafeArea(
                child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: ConvenientItems_top()),
              ),
              SafeArea(
                child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 15, 10),
                    child: ConvenientItems_bottom()),
              ),
              Container(
                  height: 35,
                  margin: EdgeInsets.fromLTRB(5, 0, 20, 0),
                  child: Align(
                      alignment: Alignment.topLeft, child: GnumapTitle())),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 15, 10),
                height: 130,
                child: Minimap(),
              )
            ]),
          ),
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
      child: CupertinoSearchTextField(
        itemSize: 20,
        decoration: BoxDecoration(
            color: Color.fromRGBO(188, 188, 188, 0.54),
            borderRadius: BorderRadius.circular(10)),
        onSubmitted: (name) async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PathInfo(name: name)),
          );
        },
      ),
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
  late List _favorites = [];
  late List _favoritesString = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  Future _getFavorites() async {
    _favorites = await _favoriteHelper.getItems();
    for (int i = 0; i < _favorites.length; i++) {
      _favoritesString.add(_favorites[i]['name']);
    }
    print(_favoritesString);
    return _favorites;
  }

  @override // setState의 구조이다.
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> favoriteItems = _favoritesString;
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: FutureBuilder(
            future: _getFavorites(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
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
                    });
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return SizedBox(
                  height: 10,
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => GnuMap()));
      },
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('GNU MAP',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(0, 16, 72, 0.6),
                  fontFamily: 'AppleSDGothicNeo')),
          Icon(Icons.arrow_forward_ios_rounded),
        ]),
      ),
    );
  }
}

class Minimap extends StatelessWidget {
  const Minimap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => GnuMap()));
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/minimap.png')),
              borderRadius: BorderRadius.circular(20),
            )));
  }
}
