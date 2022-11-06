import 'package:get/get.dart';
import 'package:gnumap/app/data/model/path_info_model.dart';
import 'package:gnumap/app/data/repository/path_info_repository.dart';

class PathInfoController extends GetxController {
  final PathInfoRepository repository;
  PathInfoController({required this.repository}) : assert(repository != null);

  final _pathInfo = PathInfo().obs;

  get pathInfo => _pathInfo.value;

  set pathInfo(value) => _pathInfo.value = value;

  getInfo(String targetLat, String targetLng) {
    repository.getInfo(targetLat, targetLng).then((data) {
      pathInfo = data;
    });
  }
}
