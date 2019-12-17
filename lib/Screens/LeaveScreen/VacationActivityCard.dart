import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Common/NoData.dart';
import 'package:hr_flex/Common/PeopleSummaryWidget.dart';
import 'package:hr_flex/Data/LeaveData.dart';

class VacationActivityCard extends StatelessWidget {
  final Function(Widget w) onTap;
  final Function viewTeamCalendar;

  VacationActivityCard({
    this.onTap,
    this.viewTeamCalendar,
  });
  final Map<dynamic, dynamic> _employeeLeaveCalendarData =
      LeaveData.employeeLeaveCalendar;

  final Map<String, dynamic> _employeeReliefOfficerData =
      LeaveData.employeeLeaveCalendar["reliefOfficer"];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sw(20.0)),
        child:
            // _employeeLeaveCalendarData.isNotEmpty
            //     ?
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Vacation Activity",
                  style: TextStyle(
                    fontSize: sf(20.0),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: sw(8.0)),
                  child: Container(
                    height: sh(35.0),
                    width: sh(35.0),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(sh(8.0)),
                      child: SvgPicture.asset(
                        "assets/images/calendar.svg",
                        color: AppColors.accentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InfoWidget(
              description: "Leave Type",
              text: _employeeLeaveCalendarData["type"] != null
                  ? _employeeLeaveCalendarData["type"]
                  : "Nothing Scheduled",
              hasDivider: true,
            ),
            InfoWidget(
              description: "Duration",
              text: _employeeLeaveCalendarData.isEmpty
                  ? "Nothing Scheduled"
                  : _employeeLeaveCalendarData["startDate"] != null
                      ? "${DateUtil().format("MMMM dd", DateTime.parse(_employeeLeaveCalendarData["startDate"]))}  -  ${DateUtil().format("MMMM dd", DateTime.parse(_employeeLeaveCalendarData["resumptionDate"]))}"
                      : "Nothing Scheduled",
              chipColor: _employeeLeaveCalendarData.isEmpty
                  ? null
                  : _employeeLeaveCalendarData["status"] != null
                      ? _employeeLeaveCalendarData["status"].toUpperCase() ==
                              "SCHEDULED"
                          ? AppColors.orangeColor
                          : AppColors.greenColor
                      : null,
              chipLabel: _employeeLeaveCalendarData.isEmpty
                  ? null
                  : _employeeLeaveCalendarData["status"] != null
                      ? _employeeLeaveCalendarData["status"].toUpperCase()
                      : null,
              hasDivider: true,
            ),
            InfoWidget(
              description: "Relief Officer",
              text: _employeeLeaveCalendarData.isEmpty
                  ? "No Leave Scheduled"
                  : _employeeReliefOfficerData["name"] != null
                      ? _employeeReliefOfficerData["name"]
                      : "No Leave Scheduled",
              image: _employeeLeaveCalendarData.isEmpty
                  ? null
                  : _employeeReliefOfficerData["image"] != null
                      ? InkWell(
                          child: imageBytes(
                            _employeeReliefOfficerData["image"],
                            sw(60.0),
                            sw(60.0),
                            false,
                          ),
                          onTap: () => onTap(
                            employeeDetails(
                                _employeeReliefOfficerData, context),
                          ),
                        )
                      : null,
              hasDivider: true,
            ),
            if (viewTeamCalendar != null)
              LeaveData.employeeLeaveTeamCalendar.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Team Calender",
                          style: TextStyle(
                            color: AppColors.greyColor.withOpacity(0.8),
                            fontSize: sf(12.0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        padding(5.0),
                        Text(
                          "No Team Calender",
                          style: TextStyle(
                            color: AppColors.darkGreyColor,
                            fontSize: sf(14.0),
                          ),
                        ),
                      ],
                    )
                  : PeopleSummaryWidget(
                      title: "Team Calendar",
                      people: LeaveData.employeeLeaveTeamCalendar,
                      summaryType: "image",
                      hasDivider: false,
                      function: viewTeamCalendar,
                    ),
          ],
        ),
        // : NoData(msg: "No current leave activity"),
      ),
    );
  }
}
