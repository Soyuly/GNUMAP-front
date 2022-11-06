import 'package:gnumap/app/data/provider/path_info_api.dart';

import '../model/my_pos_model.dart';
import '../provider/my_pos_provider.dart';

class MyPosRepository {
  final MyPosClient myPosClient;

  MyPosRepository({required this.myPosClient}) : assert(myPosClient != null);

  setPath() {
    return myPosClient.locateMe();
  }
}
