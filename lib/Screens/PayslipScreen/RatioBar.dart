import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';

class RatioBar extends StatelessWidget {
  final double first;
  final double second;

  RatioBar({this.first, this.second});
  @override
  Widget build(BuildContext context) {
    double total = first + second;
    double smallest = 0;
    if (first == second) {
      smallest = total;
    } else {
      if (first < second) {
        smallest = first;
      } else {
        smallest = second;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sh(30.0)),
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: sh(15.0),
              width: DeviceConfig.screenWidth * total / total,
              decoration: BoxDecoration(
                color: AppColors.darkGreenColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
            ),
            Container(
              height: sh(15.0),
              width: (DeviceConfig.screenWidth * smallest / total),
              decoration: BoxDecoration(
                color: AppColors.brownColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
