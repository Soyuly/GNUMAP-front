import 'package:get/get.dart';
import 'package:gnumap/app/controller/history_controller.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/provider/path_info_api.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/data/repository/path_info_repository.dart';
import 'package:http/http.dart' as http;

class MyPosBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyPosController(
        repository: MyPosRepository(myPosClient: MyPosClient())));
  }
}
