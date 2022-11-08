import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/ui/main/widgets/appbar_widget.dart';
import 'package:gnumap/app/ui/main/widgets/convenients.dart';
import 'package:gnumap/app/ui/main/widgets/favorites_item.dart';
import 'package:gnumap/app/ui/main/widgets/gnu_map_title_widget.dart';
import 'package:gnumap/app/ui/main/widgets/history_items.dart';
import 'package:gnumap/app/ui/main/widgets/item_title.dart';
import 'package:gnumap/app/ui/main/widgets/minimap_widget.dart';
import 'package:gnumap/app/ui/main/widgets/search_field.dart';
import 'package:gnumap/app/ui/gnumap/gnu_map.dart';
import 'package:gnumap/app/utils/db.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool click = true;

  TextEditingController _search = new TextEditingController();
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          systemOverlayStyle: Get.isDarkMode
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent, //appBar 투명색
          elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
          automaticallyImplyLeading: false,
          title: MainAppBar(),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(13, 15, 0, 0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SearchField(),
              HistoryItems(),
              ItemTitle(
                title: "Favorites",
              ),
              FavoritesItem(),
              ItemTitle(
                title: "Convenient",
              ),
              Conveneints(),
              SizedBox(
                height: 30,
              ),
              GnuMapTitle(),
              Minimap(),
            ]),
          ),
        ),
      ),
    );
  }
}
