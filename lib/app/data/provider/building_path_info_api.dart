import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/data/model/building_info_model.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/utils/constants.dart';
import 'package:http/http.dart' as http;

class BuildingPathInfoApiClient {
  final http.Client httpClient;
  final controller = Get.put(
      MyPosController(repository: MyPosRepository(myPosClient: MyPosClient())));
  BuildingPathInfoApiClient({required this.httpClient});

  getAll(String keyword) async {
    var baseUrl = Uri.parse(BASE_URL +
        '/v1/building/' +
        controller.me.value.lat.toString() +
        '/' +
        controller.me.value.lng.toString() +
        '/' +
        keyword);

    try {
      var response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        List<BuildingModel> listBuildingModel =
            jsonResponse.map((model) => BuildingModel.fromJson(model)).toList();
        return listBuildingModel;
      } else {
        log('Building 정보 받아오기 실패 : ' + response.statusCode.toString());
      }
    } catch (e) {
      log('Building 정보 받아오기 실패 : ' + e.toString());
    }
  }
}
