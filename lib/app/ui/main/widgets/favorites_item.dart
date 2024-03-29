import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/favorites_controller.dart';
import 'package:gnumap/app/data/model/favorites_model.dart';
import 'package:gnumap/app/data/model/history_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesItem extends GetView<FavoritesController> {
  const FavoritesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FavoritesController>(
      initState: (state) {
        Get.find<FavoritesController>().getFavorites();
      },
      builder: (_) {
        return _.items.length >= 1
            ? SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed('/path', arguments: {
                          'name': _.items[index].name,
                          'num': _.items[index].num,
                          'lat': _.items[index].lat,
                          'lng': _.items[index].lng
                        }),
                        child: SizedBox(
                          width: 75,
                          height: 100,
                          child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Scaffold(
                                    backgroundColor: Colors.transparent,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/buildings/${_.items[index].area}/min-${_.items[index].num}.jpeg',
                                        ).image),
                                    borderRadius: BorderRadius.circular(40),
                                  )),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      '${_.items[index].num}동\n${_.items[index].name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : SizedBox(height: 20);
      },
    );
  }
}
