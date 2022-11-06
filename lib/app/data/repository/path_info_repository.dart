import 'package:gnumap/app/data/provider/path_info_api.dart';

import '../model/my_pos_model.dart';

class PathInfoRepository {
  final PathInfoApiClient pathApiClient;

  PathInfoRepository({required this.pathApiClient})
      : assert(pathApiClient != null);

  getInfo(String targetLat, String targetLng) {
    return pathApiClient.getInfo(targetLat, targetLng);
  }
}
