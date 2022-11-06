import 'package:get/get.dart';
import 'package:gnumap/app/controller/favorites_controller.dart';

class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() {
      return FavoritesController();
    });
  }
}
