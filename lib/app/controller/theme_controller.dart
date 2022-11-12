import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _theme = Get.isDarkMode.obs;

  get theme => _theme.value;

  set theme(value) => _theme.value;
}
