import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class NoData extends StatelessWidget {
  final String msg;

  NoData({this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(sh(50.0)),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16.0),
        ),
      ),
    );
  }
}
