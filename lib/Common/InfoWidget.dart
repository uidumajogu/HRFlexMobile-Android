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
        padding(10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.greyColor.withOpacity(0.8),
                      fontSize: sf(12.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  padding(5.0),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.darkGreyColor,
                      fontSize: sf(14.0),
                    ),
                  ),
                ],
              ),
            ),
            if (displayChip)
              Chip(
                padding: EdgeInsets.all(sw(10.0)),
                backgroundColor: chipColor.withOpacity(0.1),
                avatar: CircleAvatar(
                  backgroundColor:
                      chipColor != null ? chipColor : AppColors.backgroundColor,
                ),
                label: Text(
                  chipLabel != null ? chipLabel : "",
                  style: TextStyle(
                    fontSize: sf(10.0),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            if (suffixWidget != null) suffixWidget,
            if (image != null) image,
          ],
        ),
        if (_hasDivider)
          Padding(
            padding: EdgeInsets.only(top: sh(10.0)),
            child: Divider(
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
