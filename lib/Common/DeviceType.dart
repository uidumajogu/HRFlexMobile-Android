import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

//This the device type getter class
class DeviceType {
  //Variable declarations
  static MediaQueryData _mediaQueryData;
  static double _shortestSide;
  static bool isPhone = false;
  static bool isTablet = false;

  //This is the build context initialization method
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _shortestSide = _mediaQueryData.size.shortestSide;
    if (_shortestSide < 550.0) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      isPhone = true;
    } else {
      isTablet = true;
    }
  }
}
