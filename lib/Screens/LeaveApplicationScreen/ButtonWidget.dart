import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class ButtonWidget extends StatelessWidget {
  final Function function;
  final String label;
  final Widget suffixIcon;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;
  final Widget prefixIcon;
  final TextAlign alignment;

  ButtonWidget({
    @required this.function,
    @required this.label,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
    this.prefixIcon,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: backgroundColor != null ? backgroundColor : AppColors.primaryColor,
      padding: EdgeInsets.all(sh(15)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sh(10.0)),
          side: BorderSide(
            color: borderColor != null ? borderColor : AppColors.primaryColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (prefixIcon != null) prefixIcon,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sh(5.0)),
              child: Text(
                label,
                textAlign: alignment == null ? TextAlign.center : alignment,
                style: TextStyle(
                    fontSize: sf(16.0),
                    fontWeight: FontWeight.w500,
                    color: labelColor != null
                        ? labelColor
                        : AppColors.accentColor),
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon
        ],
      ),
      onPressed: function,
    );
  }
}
