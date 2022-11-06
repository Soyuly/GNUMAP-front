import 'package:get/get.dart';
import 'package:gnumap/app/data/model/building_info_model.dart';
import 'package:gnumap/app/data/repository/building_path_info_repository.dart';

class BuildingPathInfoController extends GetxController {
  final BuildingPathInfoRepository repository;
  BuildingPathInfoController({required this.repository})
      : assert(repository != null);

  final _buildingsList = <BuildingModel>[].obs;

  final _building = BuildingModel().obs;

  get buildingsList => _buildingsList.value;

  set buildingsList(value) => _buildingsList.value = value;

  get building => _building.value;

  set building(value) => _building.value = value;

  getAll(String keyword) {
    repository.getAll(keyword).then((data) {
      buildingsList = data;
    });
  }
}
