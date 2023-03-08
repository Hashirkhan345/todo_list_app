
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';

import 'app_asset.dart';

// enum dropDownValue {
//   Educational,
//   Personal,
//   Social,
//   Birthday
// }

class AppData {
  // List of items in our dropdown menu
  static final List<String> todoTypes = [
    'Birthday',
    'Social',
    'Educational',
    'Personal',
    'Miscellaneous',
  ];

  static String getIconDataString( String dropDownValue) {
    if (kDebugMode) {
      print(dropDownValue);
    }
    String result = '';
    if (dropDownValue == 'Birthday') {
      result = AssetPaths.birthday;
    } else if (dropDownValue == 'Social') {
      result = AssetPaths.social;
    } else if (dropDownValue == 'Educational') {
      result = AssetPaths.educational;
    } else if (dropDownValue == 'Personal') {
      result = AssetPaths.personal;
    } else if (dropDownValue == 'Miscellaneous') {
      result = AssetPaths.miscellaneous;
    }else{
      result = AssetPaths.educational;
    }
    return result;
  }
}
