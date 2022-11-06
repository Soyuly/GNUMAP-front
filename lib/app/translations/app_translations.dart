import 'package:gnumap/app/translations/en_US/en_us_translations.dart';
import 'package:gnumap/app/translations/ko_KR/ko_kr_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'ko_KR': koKr,
    'en_US': enUS,
  };
}
