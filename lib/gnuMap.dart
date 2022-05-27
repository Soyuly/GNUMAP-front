import 'dart:io';
import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/models/db.dart';
import 'package:gnumap/pathInfo.dart';
import 'package:gnumap/mainpage.dart';
import 'package:gnumap/revise_info.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:like_button/like_button.dart';

class GnuMap extends StatelessWidget {
  const GnuMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            middle:
                Text('GNU MAP', style: Theme.of(context).textTheme.headline5)),
        body: WebViewExample());
  }
}

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse("http://203.255.3.246:5001/getInfoBuilding"),
          method: 'GET',
          headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
    );
  }
}

// // like button 클릭 시 보낼 요청

// class likeButton extends StatelessWidget {
//   String name;
//   likeButton(this.name);

//   late List _favorites = [];
//   final FavoriteHelper _favoriteHelper = FavoriteHelper();

//   Future _getFavorites() async {
//     _favorites = await _favoriteHelper.getItems();
//     print(_favorites);
//     return _favorites;
//   }

// class likeButton extends StatelessWidget {
//   String name;
//   likeButton(this.name);

//   late List _favorites = [];
//   final FavoriteHelper _favoriteHelper = FavoriteHelper();

//   Future _getFavorites() async {
//     _favorites = await _favoriteHelper.getItems();
//     print(_favorites);
//     return _favorites;
//   }

//   Future<bool> onLikeButtonTapped(bool isLiked) async {
//     late List _favorites = [];
//     final FavoriteHelper _favoriteHelper = FavoriteHelper();

//     // 즐겨찾기 추가
//     if (isLiked) {
//       _favoriteHelper.remove(this.name, 20);
//       _favoriteHelper.remove(this.name);
//       print("no");
//     }
//     // 즐겨찾기 삭제
//     else {
//       _favoriteHelper.add(this.name, 20);
//       _favoriteHelper.add(this.name);
//       print("yes");
//     }

//     return !isLiked;
//   }

//   bool isExist() {
//     for (int i = 0; i < _favorites.length; i++) {
//       if (_favorites[i]['name'] == this.name) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     String name = this.name;
//     return Container(
//         margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
//         child: FutureBuilder(
//             future: _getFavorites(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 if (isExist()) {
//                   return LikeButton(
//                     onTap: onLikeButtonTapped,
//                     size: 20,
//                     isLiked: true,
//                   );
//                 } else {
//                   return LikeButton(
//                     onTap: onLikeButtonTapped,
//                     size: 20,
//                     isLiked: false,
//                   );
//                 }
//               }
//               //error가 발생하게 될 경우 반환하게 되는 부분
//               else if (snapshot.hasError) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Error: ${snapshot.error}',
//                     style: TextStyle(fontSize: 15),
//                   ),
//                 );
//               } else {
//                 return LikeButton(
//                   onTap: onLikeButtonTapped,
//                   size: 20,
//                   isLiked: false,
//                 );
//               }
//               // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
//             }));
//   }
// }

// class slidingUpPanel extends StatelessWidget {
//   const slidingUpPanel({Key? key}) : super(key: key);

//   final result = true;

//   @override
//   Widget build(BuildContext context) {
//     final name = "30동";

//     // 검색을 진행한 상태
//     if (result) {
//       return SlidingUpPanel(
//           borderRadius: BorderRadius.circular(10.0),
//           minHeight: 100,
//           padding: EdgeInsets.only(left: 10, right: 10),
//           header: Container(
//             width: 352,
//             color: Colors.white,
//             margin: EdgeInsets.only(left: 20, right: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   child: Center(
//                     child: Column(children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 7, bottom: 5),
//                         width: 30,
//                         height: 5,
//                         decoration: BoxDecoration(color: Colors.grey[300]),
//                       )
//                     ]),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(name,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                     SizedBox(width: 6),
//                     likeButton(name)
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("소요시간 20분 소요거리 4km"),
//                 Text("경남 진주시 진주대로 501 30동"),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//           panel: ListView(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 20, left: 20, right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 90,
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         child: Image.asset('assets/cs.jpg',
//                             width: MediaQuery.of(context).size.width - 40,
//                             fit: BoxFit.fitWidth),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("건물 검색",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("1층: 상담실"),
//                     Text("2층: 열람실"),
//                     Text("3층: 308호, 312호"),
//                     Text("4층: 415호, 416호, 409호"),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, right: 20),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (_) => ReviseInfo()));
//                         },
//                         child: Text(
//                           '정보수정요청',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ]),
//               ),
//               SizedBox(
//                 height: 20,
//               )
//             ],
//           ),
//           body: Stack(
//             children: [
//               Container(
//                 child: WebViewExample(),
//               ),
//               Positioned(
//                   child: Container(
//                 margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
//                 child: SearchBar(),
//               ))
//             ],
//           ));
//     } else {
//       return Stack(
//         children: [
//           Container(
//             child: WebViewExample(),
//           ),
//           Positioned(
//               child: Container(
//             margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
//             child: SearchBar(),
//           ))
//         ],
//       );
//     }
//   }
// }
