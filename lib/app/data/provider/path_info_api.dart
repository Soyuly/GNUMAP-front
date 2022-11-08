import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/data/model/path_info_model.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/utils/constants.dart';
import 'package:http/http.dart' as http;

class PathInfoApiClient {
  final http.Client httpClient;
  PathInfoApiClient({required this.httpClient});
  final controller = Get.put(
      MyPosController(repository: MyPosRepository(myPosClient: MyPosClient())));
  getInfo(String targetLat, String targetLng) async {
    final baseUrl = Uri.parse(BASE_URL +
        '/v1/convenient/' +
        controller.me.lat.toString() +
        '/' +
        controller.me.lng.toString() +
        '/' +
        targetLat +
        '/' +
        targetLng +
        '/');

    try {
      var response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        PathInfo model = PathInfo.fromJson(result);

        return model;
      } else {
        log("경로 검색 에러 : " + response.statusCode.toString());
      }
    } catch (e) {
      log("경로 검색 에러 : " + e.toString());
    }
  }
}
