import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/PayrollData.dart';

Widget sendPayrollInfoWidget(BuildContext context, String type,
    Function(String type, String querry) sendInfo, Function openDatePicker) {
  PayrollData().resetRangeValues();

  return Padding(
    padding: EdgeInsets.all(sh(10.0)),
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(sh(10.0)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                padding(10.0),
                Padding(
                  padding: EdgeInsets.all(sh(10.0)),
                  child: Container(
                    child: Text(
                      "Send a copy of your $type to your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: sf(12.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
                InkWell(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(sh(15.0)),
                      child: Text(
                        "Current Year till date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.darkGreenColor,
                          fontSize: sf(22.0),
                        ),
                      ),
                    ),
                  ),
                  onTap: () => sendInfo(type, "none"),
                ),
                Divider(
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
                InkWell(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(sh(15.0)),
                      child: Text(
                        "Choose a custom range",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.darkGreenColor,
                          fontSize: sf(22.0),
                        ),
                      ),
                    ),
                  ),
                  onTap: openDatePicker,
                ),
                padding(10.0),
              ],
            ),
          ),
        ),
        padding(10.0),
        InkWell(
          child: Container(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(sh(10.0)),
                ),
              ),
              child: Column(
                children: <Widget>[
                  padding(10.0),
                  Padding(
                    padding: EdgeInsets.all(sh(10.0)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.darkGreenColor,
                        fontSize: sf(22.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  padding(10.0),
                ],
              ),
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
