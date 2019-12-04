import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomBarIcon.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/LeaveData.dart';

Widget bottomNavigation(BuildContext context, String screenName) {
  return Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
          color: Colors.black54, blurRadius: 1.5, offset: Offset(0.0, 0.75))
    ], color: AppColors.whiteColor),
    child: BottomAppBar(
      color: AppColors.whiteColor,
      elevation: 0.0,
      child: Container(
        height: sh(60.0),
        width: DeviceConfig.screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(10.0)),
          child: Padding(
            padding: EdgeInsets.all(sh(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BottomBarIcon(
                  icon: "assets/images/dashboard.svg",
                  iconText: "Home",
                  isActive: screenName == "dashboard",
                  onTap: () => pushScreen(context, "/DashboardScreen"),
                ),
                BottomBarIcon(
                  icon: "assets/images/payslip.svg",
                  iconText: "Payslips",
                  isActive: screenName == "payslip",
                  onTap: () => pushScreen(context, "/PayslipScreen"),
                ),
                Stack(
                  children: <Widget>[
                    if (LeaveData.employeeLeaveTasks.isNotEmpty)
                      BottomBarIcon(
                        icon: "assets/images/calendar.svg",
                        isActive: screenName == "leave",
                        iconText: "Leave",
                        onTap: () => pushScreen(context, "/LeaveScreen"),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sh(37.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: sh(25.0),
                        width: sh(25.0),
                        decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.circle),
                        child: Text(
                          "${LeaveData.employeeLeaveTasks.length}",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: sf(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
