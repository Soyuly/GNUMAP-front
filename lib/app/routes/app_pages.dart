import 'package:get/get.dart';
import 'package:gnumap/app/binding/building_path_info_binding.dart';
import 'package:gnumap/app/binding/convenient_binding.dart';
import 'package:gnumap/app/binding/favorites_binding.dart';
import 'package:gnumap/app/binding/mypos_binding.dart';
import 'package:gnumap/app/binding/path_info_binding.dart';
import 'package:gnumap/app/binding/revise_binding.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/ui/bus/bus_page.dart';
import 'package:gnumap/app/ui/bus/widgets/bus_webview_widget.dart';
import 'package:gnumap/app/ui/convenients/Convenience.dart';
import 'package:gnumap/app/ui/gnumap/gnu_map.dart';
import 'package:gnumap/app/ui/main/mainpage.dart';
import 'package:gnumap/app/ui/path/pathInfo.dart';
import 'package:gnumap/app/ui/result/result_page.dart';
import 'package:gnumap/app/ui/revise/revise_info.dart';
import 'package:gnumap/app/ui/settings/settings.dart';
import 'package:gnumap/app/ui/splash/splash_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => Splash()),
    GetPage(
        name: Routes.MAIN,
        page: () => MainPage(),
        bindings: [MyPosBinding(), FavoritesBinding()]),
    GetPage(
        name: Routes.PATH,
        page: () => PathResult(),
        binding: PathInfoBinding()),
    GetPage(name: Routes.SETTING, page: () => Setting()),
    GetPage(
        name: Routes.REVISE,
        page: () => ReviseInfo(),
        binding: ReviseBinding()),
    GetPage(name: Routes.MAP, page: () => GnuMap()),
    GetPage(name: Routes.BUS, page: () => BusMap()),
    GetPage(
        name: Routes.CONVENIENT,
        page: () => ConvenientPage(),
        binding: ConvenientBinding()),
    GetPage(
        name: Routes.RESULT,
        page: () => ResultPage(),
        binding: BuildingPathInfoBinding())
  ];
}
