import 'package:get/get.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:gnumap/app/data/model/path_info_model.dart';
import 'package:gnumap/app/data/provider/path_info_api.dart';
import 'package:gnumap/app/data/repository/path_info_repository.dart';
import 'package:http/http.dart' as http;

class PathInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PathInfoController>(() {
      return PathInfoController(
          repository: PathInfoRepository(
              pathApiClient: PathInfoApiClient(
        httpClient: http.Client(),
      )));
    });
  }
}
