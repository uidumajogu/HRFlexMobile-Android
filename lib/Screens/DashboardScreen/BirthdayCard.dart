import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleSummaryWidget.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Data/EmployeeData.dart';

class BirthdayCard extends StatelessWidget {
  final Function(Widget w) onTap;
  final List<dynamic> _birthdaysTodayData = EmployeeData.birthdaysToday;
  final int _birthdaysTodayListLength = EmployeeData.birthdaysTodayListLength;
  final Function(List<dynamic> bl) goToBirthdays;

  BirthdayCard({
    @required this.goToBirthdays,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sw(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateUtil().format("MMMM dd", DateUtil().now),
                      style: TextStyle(
                        color: AppColors.brownColor,
                        fontSize: sw(12.0),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding(3.0),
                    Row(
                      children: <Widget>[
                        Text(
                          "Birthdays",
                          style: TextStyle(
                              color: AppColors.lightPrimaryColor,
                              fontSize: sf(18.0),
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: sh(5.0)),
                          child: SvgPicture.asset(
                            "assets/images/CalendarIcon.svg",
                            color: AppColors.brownColor,
                            width: sw(20.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (_birthdaysTodayData.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: sh(5.0)),
                child: Divider(
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
              ),
            _birthdaysTodayData.isEmpty
                ? PeopleWidget(
                    description: "No birthdays today!",
                  )
                : PeopleSummaryWidget(
                    people: _birthdaysTodayData,
                    summaryType: "image",
                    hasDivider: false,
                    function: () => goToBirthdays(_birthdaysTodayData),
                  ),
          ],
        ),
      ),
    );
  }
}
