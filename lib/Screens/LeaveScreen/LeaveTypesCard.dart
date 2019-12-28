import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';

class LeaveTypesCard extends StatelessWidget {
  final Map<dynamic, dynamic> leaveTypeData;
  final Function goToLeaveApplication;
  final bool lastCard;

  LeaveTypesCard({
    @required this.leaveTypeData,
    @required this.goToLeaveApplication,
    @required this.lastCard,
  });
  @override
  Widget build(BuildContext context) {
    double _rightMargin = 0.0;
    if (lastCard) {
      _rightMargin = 8.0;
    }

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
            left: sw(8.0), right: sw(_rightMargin), bottom: sw(8.0)),
        width: sh(200.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(sw(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Apply for Leave",
                      style: TextStyle(
                        fontSize: sf(12.0),
                        color: AppColors.brownColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/images/CalendarIcon.svg",
                      color: AppColors.brownColor,
                      width: sw(25.0),
                    ),
                  ],
                ),
                padding(5.0),
                Container(
                  height: sh(40.0),
                  child: Text(
                    leaveTypeData["type"],
                    // leaveTypeData["type"].split(" ")[0],
                    style: TextStyle(
                      fontSize: sf(18.0),
                      color: AppColors.lightPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text(
                //   "Leave",
                //   style: TextStyle(
                //     fontSize: sf(24.0),
                //     color: AppColors.lightPrimaryColor,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                padding(5.0),
                Divider(
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
                padding(5.0),
                Text(
                  "Available Days",
                  style: TextStyle(
                    color: AppColors.greyColor.withOpacity(0.8),
                    fontSize: sf(11.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                padding(5.0),
                Text(
                  "${leaveTypeData["available"].toString()} ${leaveTypeData["mode"].toString()}",
                  style: TextStyle(
                    color: AppColors.darkGreyColor,
                    fontSize: sf(12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => goToLeaveApplication(leaveTypeData),
    );
  }
}
