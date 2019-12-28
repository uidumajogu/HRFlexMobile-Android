import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';

class PeopleWidget extends StatelessWidget {
  final String description;
  final String description2;
  final String name;
  final Widget image;
  final bool hasDivider;
  final Color chipColor;
  final String chipLabel;
  final Widget suffixWidget;

  PeopleWidget({
    this.description,
    this.description2,
    this.name,
    this.image,
    this.hasDivider,
    this.chipColor,
    this.chipLabel,
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
        padding(5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (image != null) image,
                  if (image != null)
                    Padding(
                      padding: EdgeInsets.only(right: sh(15.0)),
                    ),
                  if (name != null || description != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (name != null)
                            Text(
                              name,
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: sf(14.0),
                              ),
                            ),
                          padding(5.0),
                          if (description != null)
                            Container(
                              width: DeviceConfig.screenWidth * 0.65,
                              child: Text(
                                description,
                                style: TextStyle(
                                  color: AppColors.darkGreyColor,
                                  fontSize: sf(11.0),
                                ),
                              ),
                            ),
                          if (description2 != null)
                            Container(
                              width: DeviceConfig.screenWidth * 0.65,
                              child: Text(
                                description2,
                                style: TextStyle(
                                  color: AppColors.darkGreyColor,
                                  fontSize: sf(11.0),
                                ),
                              ),
                            ),
                        ],
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
            //   padding: EdgeInsets.all(sw(10.0)),
            //   backgroundColor: chipColor.withOpacity(0.1),
            //   avatar: CircleAvatar(
            //     backgroundColor:
            //         chipColor != null ? chipColor : AppColors.backgroundColor,
            //   ),
            //   label: Text(
            //     chipLabel != null ? chipLabel : "",
            //     style: TextStyle(
            //       fontSize: sf(10.0),
            //       fontWeight: FontWeight.bold,
            //       color: AppColors.primaryColor,
            //     ),
            //   ),
            // ),
            if (suffixWidget != null)
              suffixWidget
          ],
        ),
        if (_hasDivider)
          Padding(
            padding: EdgeInsets.only(top: sh(5.0)),
            child: Divider(
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
