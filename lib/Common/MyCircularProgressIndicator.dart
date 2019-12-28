import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  MyCircularProgressIndicator({
    this.size,
    this.strokeWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size != null ? sw(size) : sw(25.0),
      width: size != null ? sw(size) : sw(25.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
            color != null ? color : AppColors.lightPrimaryColor),
        strokeWidth: strokeWidth != null ? sw(strokeWidth) : sw(2.0),
      ),
    );
  }
}
