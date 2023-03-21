import 'package:get/get.dart';

class AreaController extends GetxController {
  final _area = "가좌".obs;

  get area => _area.value;
  set area(value) => _area.value = value;
}
