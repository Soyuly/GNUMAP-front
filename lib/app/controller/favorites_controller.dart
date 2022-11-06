import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/data/model/favorites_model.dart';
import 'package:hive/hive.dart';

class FavoritesController extends GetxController {
  final _items = [].obs;

  get items => _items;

  set items(value) => _items.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    try {
      Hive.registerAdapter(FavoritesAdapter());
    } catch (e) {
      log("Hive 즐겨찾기 에러 : " + e.toString());
    }
    getFavorites();
    super.onInit();
  }

  addFavorites(Favorites favorite) async {
    items.add(favorite);
    var box = await Hive.openBox('favorites');
    box.put('favorites', items.toList());
    log('Favorites 아이템 추가 되었음 $favorite');
  }

  Future getFavorites() async {
    Box box;
    try {
      box = Hive.box('favorites');
    } catch (e) {
      box = await Hive.openBox('favorites');
    }

    var favorites = box.get('favorites');

    if (favorites != null) items = favorites;
  }

  deleteFavorites(Favorites favorites) async {
    items.remove(favorites);
    var box = await Hive.openBox('favorites');
    box.put('favorites', items.toList());
    log("Favorite 객체 삭제됨");
  }

  deleteFavoriteByNum(int num) async {
    final favorite =
        (items.firstWhere((item) => item.num == num, orElse: () => false));

    if (favorite != false) {
      items.remove(favorite);
    } else {
      return false;
    }

    var box = await Hive.openBox('history');
    box.put('history', items.toList());
    log("Favorite 객체 삭제됨");
  }

  bool isExisted(int num) {
    final isExisted =
        (items.firstWhere((item) => item.num == num, orElse: () => false));

    if (isExisted == false) {
      return false;
    }
    return true;
  }
}
