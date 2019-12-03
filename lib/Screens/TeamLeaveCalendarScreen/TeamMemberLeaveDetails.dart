import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Common/NoData.dart';

class TeamMemberLeaveDetails extends StatelessWidget {
  final Map<dynamic, dynamic> employeeLeaveCalendar;

  TeamMemberLeaveDetails({
    this.employeeLeaveCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _employeeLeaveCalendarData =
        employeeLeaveCalendar;

    final Map<String, dynamic> _employeeReliefOfficerData =
        employeeLeaveCalendar["reliefOfficer"];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sw(20.0)),
        child: _employeeLeaveCalendarData.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${_employeeLeaveCalendarData["employee"]["name"]}",
                        style: TextStyle(
                          fontSize: sf(28.0),
                          color: AppColors.lightPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      imageBytes(
                        _employeeLeaveCalendarData["employee"]["image"],
                        sw(60.0),
                        sw(60.0),
                        false,
                      ),
                    ],
                  ),
                  InfoWidget(
                    description: "Leave Type",
                    text: _employeeLeaveCalendarData["type"] != null
                        ? _employeeLeaveCalendarData["type"]
                        : "Not Available",
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Duration",
                    text: _employeeLeaveCalendarData["startDate"] != null
                        ? "${DateUtil().format("MMMM dd", DateTime.parse(_employeeLeaveCalendarData["startDate"]))}  -  ${DateUtil().format("MMMM dd", DateTime.parse(_employeeLeaveCalendarData["resumptionDate"]))}"
                        : "Nothing Scheduled",
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Email",
                    text: _employeeLeaveCalendarData["employee"]["email"],
                    image: InkWell(
                      child: image("assets/images/sendEmail.png", 25.0,
                          AppColors.accentColor),
                      onTap: () {
                        Navigator.pop(context);
                        openEmail(
                            _employeeLeaveCalendarData["employee"]["email"]);
                      },
                    ),
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Relief Officer",
                    text: _employeeReliefOfficerData["name"] != null
                        ? _employeeReliefOfficerData["name"]
                        : "Not Available",
                    image: _employeeReliefOfficerData["image"] != null
                        ? InkWell(
                            child: imageBytes(
                              _employeeReliefOfficerData["image"],
                              sw(60.0),
                              sw(60.0),
                              false,
                            ),
                            onTap: () => modalBottomSheetMenu(
                              context,
                              employeeDetails(
                                  _employeeReliefOfficerData, context),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(0.0),
                          ),
                    hasDivider: false,
                  ),
                ],
              )
            : NoData(msg: "No current leave activity"),
      ),
    );
  }
}
