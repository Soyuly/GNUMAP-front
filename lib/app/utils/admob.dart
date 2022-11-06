import 'package:flutter/foundation.dart';

const Map<String, String> BANNER_UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-8024302282258736/6367813900',
        'android': 'ca-app-pub-8024302282258736/3294928008',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

const Map<String, String> SCREEN_UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-8024302282258736/2053998528',
        'android': 'ca-app-pub-8024302282258736/3367080192',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/1712485313',
        'android': 'ca-app-pub-3940256099942544/5224354917',
      };
