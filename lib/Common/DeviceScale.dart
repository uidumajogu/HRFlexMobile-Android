import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceScale {
  static var scale = ScreenUtil.instance;

  void init(BuildContext context) {
    double defaultScreenWidth = 392.72727272727275;
    double defaultScreenHeight = 737.4545454545455;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
  }
}
