import 'package:flutter/widgets.dart';

//This the screen size and orientation configurations class
class DeviceConfig {
  //Variable declarations
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double pixelRatio;
  static Orientation orientation;

  //This is the build context initialization method
  void init(BuildContext context) {
    _safeAreaHorizontal = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    _safeAreaVertical = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    pixelRatio = MediaQuery.of(context).devicePixelRatio;

    orientation = MediaQuery.of(context).orientation;
  }
}
