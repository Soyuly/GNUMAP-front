import 'package:get/get.dart';
import 'package:gnumap/app/controller/building_path_info_controller.dart';
import 'package:gnumap/app/data/provider/building_path_info_api.dart';
import 'package:gnumap/app/data/repository/building_path_info_repository.dart';
import 'package:http/http.dart' as http;

class BuildingPathInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuildingPathInfoController>(() {
      return BuildingPathInfoController(
          repository: BuildingPathInfoRepository(
              apiClient: BuildingPathInfoApiClient(httpClient: http.Client())));
    });
  }
}
