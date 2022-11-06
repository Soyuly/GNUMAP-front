import 'package:gnumap/app/data/provider/building_path_info_api.dart';

class BuildingPathInfoRepository {
  final BuildingPathInfoApiClient apiClient;

  BuildingPathInfoRepository({required this.apiClient})
      : assert(apiClient != null);

  getAll(String keyword) {
    return apiClient.getAll(keyword);
  }
}
