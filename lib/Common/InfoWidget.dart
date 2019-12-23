import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';

import 'package:hr_flex/Common/Functions.dart';

class InfoWidget extends StatelessWidget {
  final String description;
  final String text;
  final Color chipColor;
  final String chipLabel;
  final Widget image;
  final bool hasDivider;
  final Widget suffixWidget;

  InfoWidget({
    this.description,
    this.text,
    this.chipColor,
    this.chipLabel,
    this.image,
    this.hasDivider,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    bool displayChip = chipColor != null || chipLabel != null;
    bool _hasDivider = false;
    if (hasDivider != null) {
      _hasDivider = hasDivider;
    }
    return Column(
      children: <Widget>[
        padding(sh(5.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.greyColor.withOpacity(0.8),
                      fontSize: sf(11.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  padding(5.0),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.darkGreyColor,
                      fontSize: sf(12.0),
                    ),
                  ),
                ],
              ),
            ),
            if (displayChip)
              Container(
                padding: EdgeInsets.all(sh(5.0)),
                decoration: BoxDecoration(
                  color: chipColor.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(sh(25.0))),
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: sw(5.0),
                      backgroundColor: chipColor != null
                          ? chipColor
                          : AppColors.backgroundColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sh(3.0)),
                      child: Text(
                        chipLabel != null ? chipLabel : "",
                        style: TextStyle(
                          fontSize: sf(9.5),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Chip(
            //   backgroundColor: chipColor.withOpacity(0.1),
            //   avatar: CircleAvatar(
            //     maxRadius: sw(8.0),
            //     backgroundColor:
            //         chipColor != null ? chipColor : AppColors.backgroundColor,
            //   ),
            //   label: Text(
            //     chipLabel != null ? chipLabel : "",
            //     style: TextStyle(
            //       fontSize: sf(8.0),
            //       fontWeight: FontWeight.bold,
            //       color: AppColors.primaryColor,
            //     ),
            //   ),
            //   // labelPadding: EdgeInsets.only(left: 5.0),
            // ),
            if (suffixWidget != null)
              suffixWidget,
            if (image != null)
              image,
          ],
        ),
        if (_hasDivider)
          Padding(
            padding: EdgeInsets.only(top: sh(0.0)),
            child: Divider(
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
