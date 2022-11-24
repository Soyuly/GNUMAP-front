import 'package:flutter/material.dart';
import 'package:gnumap/app/translations/app_translations.dart';
import 'package:gnumap/app/ui/theme/light_theme.dart';
import 'package:gnumap/app/ui/theme/dark_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Hive.initFlutter();

  runApp(GetMaterialApp(
    theme: lightThemeData,
    darkTheme: darkThemeData,
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    defaultTransition: Transition.cupertino,
    locale: Get.deviceLocale,
    translationsKeys: AppTranslation.translations,
    getPages: AppPages.pages,
  ));
}
