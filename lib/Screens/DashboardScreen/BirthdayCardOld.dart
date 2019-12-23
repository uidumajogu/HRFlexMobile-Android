import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
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
                    Text(
                      "Birthdays",
                      style: TextStyle(
                          color: AppColors.lightPrimaryColor,
                          fontSize: sf(18.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (_birthdaysTodayData.isNotEmpty &&
                    _birthdaysTodayListLength > 3)
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () => goToBirthdays(_birthdaysTodayData),
                  ),
              ],
            ),
            _birthdaysTodayData.isEmpty
                ? PeopleWidget(
                    description: "No birthdays today!",
                  )
                : Column(
                    children: _birthdaysTodayData
                        .take(3)
                        .map<Widget>((bdt) => PeopleWidget(
                              name: bdt["name"],
                              description: bdt["designation"],
                              image: InkWell(
                                child: imageBytes(
                                  bdt["image"],
                                  sw(60.0),
                                  sw(60.0),
                                  false,
                                ),
                                onTap: () =>
                                    onTap(employeeDetails(bdt, context)),
                              ),
                              hasDivider: bdt ==
                                      _birthdaysTodayData[
                                          _birthdaysTodayData.take(3).length -
                                              1]
                                  ? false
                                  : true,
                            ))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
