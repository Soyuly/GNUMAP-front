import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/main/widgets/appbar_widget.dart';
import 'package:gnumap/app/ui/main/widgets/convenients.dart';
import 'package:gnumap/app/ui/main/widgets/favorites_item.dart';
import 'package:gnumap/app/ui/main/widgets/gnu_map_title_widget.dart';
import 'package:gnumap/app/ui/main/widgets/history_items.dart';
import 'package:gnumap/app/ui/main/widgets/item_title.dart';
import 'package:gnumap/app/ui/main/widgets/minimap_widget.dart';
import 'package:gnumap/app/ui/main/widgets/search_field.dart';
import 'package:gnumap/app/ui/main/widgets/top_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool click = true;

  TextEditingController _search = new TextEditingController();
  String text = "";
  DateTime? currentBackPressTime;

  // 2번 눌러서 앱 종료하기
  Future<bool> onWillPop() async {
    print("실행");
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      Get.snackbar('지누맵 종료하기', '한번 더 뒤로가기를 누르면 지누맵이 종료됩니다.',
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut);
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
            systemOverlayStyle: context.isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent, //appBar 투명색
            elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
            automaticallyImplyLeading: false,
            title: MainAppBar(),
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            return onWillPop();
          },
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(13, 15, 0, 0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainTopWidget(),
                      HistoryItems(),
                      ItemTitle(
                        title: "favorites".tr,
                      ),
                      FavoritesItem(),
                      ItemTitle(
                        title: "convenient".tr,
                      ),
                      Conveneints(),
                      SizedBox(
                        height: 40,
                      ),
                      GnuMapTitle(),
                      Minimap(),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
