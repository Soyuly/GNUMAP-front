import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gnumap/settings.dart';
import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gnumap/CImages.dart';
import 'package:gnumap/gnuMap.dart';
import 'package:gnumap/pathInfo.dart';
import 'package:gnumap/models/db.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool click = true;

  late List _histories = [];
  final HistoryHelper _historyHelper = HistoryHelper();

  Future _getHistories() async {
    _histories = await _historyHelper.getItems();
    print(_histories);
    return _histories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, //appBar 투명색
        elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
        title: Container(
          margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('gnumap'), style: Theme.of(context).textTheme.headline1),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: IconButton(
                        padding: EdgeInsets.zero, // 패딩 설정
                        constraints: BoxConstraints(), // constraints
                        onPressed: () {
                          bool isDarkModeOn =
                              Theme.of(context).brightness == Brightness.dark;

                          setState(() {
                            click = !click;
                            if (isDarkModeOn) {
                              EasyDynamicTheme.of(context).changeTheme();
                            } else {
                              EasyDynamicTheme.of(context)
                                  .changeTheme(dark: true);
                            }
                          });
                        },
                        icon: Icon(
                            (click == false)
                                ? Icons.brightness_2_sharp
                                : Icons.sunny,
                            color: Theme.of(context).primaryColor)),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero, // 패딩 설정
                    constraints: BoxConstraints(), // constraints
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingPage(title: "설정")));
                    },
                    icon: Icon(Icons.settings,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(13, 15, 0, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              SafeArea(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                child: CupertinoSearchTextField(
                  itemSize: 20,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(188, 188, 188, 0.54),
                      borderRadius: BorderRadius.circular(10)),
                  onSubmitted: (name) async {
                    try {
                      bool isBack = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PathInfo(name: name.replaceAll("동", ""))),
                      );

                      if (isBack) {
                        setState(() {
                          _getHistories();
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              )),
              SizedBox(
                  height: 35,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
                      child: FutureBuilder(
                          future: _getHistories(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return Container(child: Text(tr('loading')));
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
                                          showCupertinoDialog(
                                              context: context,
                                              useRootNavigator: false,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Text('히스토리 항목 삭제'),
                                                  content: Text(
                                                      '히스토리${_histories[index]['name']}를 정말 삭제하시겠습니까?'),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        child: Text(
                                                          "삭제",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        onPressed: () async {
                                                          print('삭제');
                                                          await _historyHelper
                                                              .remove(
                                                                  _histories[
                                                                          index]
                                                                      ['name']);
                                                          setState(() {
                                                            _getHistories();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                    CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        child: Text("취소"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ],
                                                );
                                              });
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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

class FavoriteTitle extends StatelessWidget {
  const FavoriteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
      child:
          Text(tr('favorites'), style: Theme.of(context).textTheme.headline2),
    );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List _favorites = [];
  late List _favoritesString = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  Future _getFavorites() async {
    _favoritesString.clear();
    _favorites = await _favoriteHelper.getItems();
    // for (int i = 0; i < _favorites.length; i++) {
    //   _favoritesString.add(_favorites[i]['name']);
    // }
    print(_favoritesString);
    return _favoritesString;
  }

  // _getFavorites();
  // @override // setState의 구조이다.
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  // }

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
                          child: GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => GnuMap()));
                            },
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
                          ));
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
      child:
          Text(tr('convenient'), style: Theme.of(context).textTheme.headline2),
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
          Text('GNU MAP', style: Theme.of(context).textTheme.headline3),
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

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
