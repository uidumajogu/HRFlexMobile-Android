import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class BottomBarIcon extends StatelessWidget {
  final String icon;
  final String iconText;
  final bool isActive;
  final Function onTap;

  BottomBarIcon({this.icon, this.iconText, this.isActive, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: sh(22.0),
              width: sh(22.0),
              child: SvgPicture.asset(
                icon,
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.greyColor.withOpacity(0.4),
              ),
            ),
            Text(
              iconText,
              style: TextStyle(
                fontSize: sf(10.0),
                fontWeight: FontWeight.w700,
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.greyColor.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
