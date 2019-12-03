import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';

class LeaveCard extends StatelessWidget {
  final Function goToLeaveActivity;

  LeaveCard({
    @required this.goToLeaveActivity,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sh(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: sh(30.0),
                      width: sh(30.0),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/images/calendar.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sw(5.0)),
                      child: Text(
                        "My Leave Activity",
                        style: TextStyle(
                            color: AppColors.lightPrimaryColor,
                            fontSize: sf(22.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: goToLeaveActivity,
                ),
              ],
            ),
            InfoWidget(
              description: "Leave Type",
              text: "Annual Leave",
              hasDivider: true,
            ),
            InfoWidget(
              description: "Duration",
              text: "March 28 - April 15",
              hasDivider: true,
            ),
            InfoWidget(
              description: "Relief Officer",
              text: "Aergon Targaryen",
              // image: _employeeImageBytes,
            ),
          ],
        ),
      ),
    );
  }
}
