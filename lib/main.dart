import 'package:flutter/material.dart';
import 'package:gnumap/app/data/model/favorites_model.dart';
import 'package:gnumap/app/data/model/history_model.dart';
import 'package:gnumap/app/translations/app_translations.dart';
import 'package:gnumap/app/ui/main/mainpage.dart';
import 'package:gnumap/app/ui/splash/splash_page.dart';
import 'package:gnumap/app/ui/theme/light_theme.dart';
import 'package:gnumap/app/ui/theme/dark_theme.dart';
import 'package:location/location.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:gnumap/app/utils/db.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Hive.initFlutter();

  runApp(GetMaterialApp(
    theme: lightThemeData,
    darkTheme: darkThemeData,
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    defaultTransition: Transition.cupertino,
    locale: Get.deviceLocale,
    translationsKeys: AppTranslation.translations,
    getPages: AppPages.pages,
  ));
}
