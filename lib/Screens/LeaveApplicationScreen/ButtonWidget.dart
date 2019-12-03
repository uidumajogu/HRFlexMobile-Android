import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class ButtonWidget extends StatelessWidget {
  final Function function;
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;

  ButtonWidget({
    @required this.function,
    @required this.label,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: backgroundColor != null ? backgroundColor : AppColors.primaryColor,
      padding: EdgeInsets.all(sh(16)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sh(10.0)),
          side: BorderSide(
            color: borderColor != null ? borderColor : AppColors.primaryColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: sf(16.0),
                  fontWeight: FontWeight.w500,
                  color:
                      labelColor != null ? labelColor : AppColors.accentColor),
            ),
          ),
          if (icon != null) icon
        ],
      ),
      onPressed: function,
    );
  }
}
