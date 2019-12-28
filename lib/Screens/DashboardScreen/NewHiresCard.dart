import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleSummaryWidget.dart';
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
                          "This Week",
                          // "Week starting ${DateUtil().format("MMMM dd", DateUtil().recentMonday())}",
                          style: TextStyle(
                            color: AppColors.brownColor,
                            fontSize: sf(12.0),
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding(3.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "New Hires",
                              style: TextStyle(
                                  color: AppColors.lightPrimaryColor,
                                  fontSize: sf(18.0),
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: sh(5.0)),
                              child: SvgPicture.asset(
                                "assets/images/HiresIcon.svg",
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
              ],
            ),
            if (_newHires.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: sh(5.0)),
                child: Divider(
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
              ),
            _newHires.isEmpty
                ? PeopleWidget(
                    description: "No new hires this week!",
                  )
                : PeopleSummaryWidget(
                    people: _newHires,
                    summaryType: "image",
                    hasDivider: false,
                    function: () => goToNewHires(_newHires),
                  ),
          ],
        ),
      ),
    );
  }
}
