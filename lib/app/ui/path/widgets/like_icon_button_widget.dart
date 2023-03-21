import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/favorites_controller.dart';
import 'package:gnumap/app/data/model/favorites_model.dart';

class LikeIconButton extends StatelessWidget {
  const LikeIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoritesController controller = Get.put(FavoritesController());

    if (Get.arguments['num'] != null) {
      return IconButton(
          onPressed: () async {
            bool isExisted =
                Get.find<FavoritesController>().isExisted(Get.arguments['num']);

            if (isExisted) {
              Get.find<FavoritesController>()
                  .deleteFavoriteByNum(Get.arguments['num']);
            } else {
              final favorite = Favorites(
                  name: Get.arguments['name'],
                  num: Get.arguments['num'],
                  lat: Get.arguments['lat'],
                  lng: Get.arguments['lng'],
                  area: Get.arguments['area']);
              Get.find<FavoritesController>().addFavorites(favorite);
            }
          },
          icon: Obx(() => controller.isExisted(Get.arguments['num'])
              ? Icon(
                  Icons.favorite,
                  color: Colors.pink,
                )
              : Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.pink,
                )));
    } else {
      return SizedBox.shrink();
      ;
    }
  }
}
