import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Data/EmployeeData.dart';

class NewHiresCard extends StatelessWidget {
  final Function(Widget w) onTap;
  final List<dynamic> _newHires = EmployeeData.newHires;
  final int _newHiresListLength = EmployeeData.newHiresListLength;
  final Function(List<dynamic> bl) goToNewHires;

  NewHiresCard({
    @required this.goToNewHires,
    @required this.onTap,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Week starting ${DateUtil().format("MMMM dd", DateUtil().recentMonday())}",
                          style: TextStyle(
                            color: AppColors.brownColor,
                            fontSize: sf(14.0),
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding(3.0),
                        Text(
                          "New Hires",
                          style: TextStyle(
                              color: AppColors.lightPrimaryColor,
                              fontSize: sf(22.0),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_newHiresListLength > 3)
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () => goToNewHires(_newHires),
                  ),
              ],
            ),
            _newHires.isEmpty
                ? PeopleWidget(
                    description: "No new hires this week!",
                  )
                : Column(
                    children: _newHires
                        .take(3)
                        .map<Widget>((nh) => PeopleWidget(
                              name: nh["name"],
                              description: nh["designation"],
                              image: InkWell(
                                  child: imageBytes(
                                    nh["image"],
                                    sh(60.0),
                                    sh(60.0),
                                    false,
                                  ),
                                  onTap: () =>
                                      onTap(employeeDetails(nh, context))),
                              hasDivider:
                                  nh == _newHires[_newHires.take(3).length - 1]
                                      ? false
                                      : true,
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
