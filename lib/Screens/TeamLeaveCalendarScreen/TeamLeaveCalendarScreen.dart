import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Data/LeaveData.dart';
import 'package:hr_flex/Screens/TeamLeaveCalendarScreen/TeamMemberLeaveDetails.dart';

class TeamLeaveCalendarScreen extends StatefulWidget {
  @override
  _TeamLeaveCalendarScreenState createState() =>
      _TeamLeaveCalendarScreenState();
}

class _TeamLeaveCalendarScreenState extends State<TeamLeaveCalendarScreen> {
  bool _isLoading;
  List leaveTeamCalendarData = LeaveData.employeeLeaveTeamCalendar;

  // This instantiates the team leave calendar screen properties
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(right: sw(8.0)),
            child: Text(
              "Team Calendar",
              style: TextStyle(
                fontSize: sf(20.0),
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: _isLoading
            ? Container(
                height: DeviceConfig.screenHeight,
                width: DeviceConfig.screenWidth,
                color: AppColors.lightColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: sw(50.0),
                        width: sw(50.0),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.accentColor),
                          strokeWidth: sw(5.0),
                        ),
                      ),
                      padding(30.0),
                      Padding(
                        padding: EdgeInsets.all(sw(30.0)),
                        child: Text(
                          "Getting your leave activity...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: sf(14.0),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: sh(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    padding(20.0),
                    Text(
                      "Next 30 Days",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: sf(18.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding(10.0),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: leaveTeamCalendarData
                                  .map<Widget>((teamMember) => PeopleWidget(
                                        name: teamMember["employee"]["name"],
                                        description: teamMember["startDate"] !=
                                                null
                                            ? "${DateUtil().format("MMMM dd", DateTime.parse(teamMember["startDate"]))}  -  ${DateUtil().format("MMMM dd", DateTime.parse(teamMember["resumptionDate"]))}"
                                            : "Nothing Scheduled",
                                        image: InkWell(
                                          child: imageBytes(
                                            teamMember["employee"]["image"],
                                            sh(60.0),
                                            sh(60.0),
                                            false,
                                          ),
                                          onTap: () => modalBottomSheetMenu(
                                            context,
                                            TeamMemberLeaveDetails(
                                              employeeLeaveCalendar: teamMember,
                                            ),
                                          ),
                                        ),
                                        chipColor: teamMember["status"] != null
                                            ? teamMember["status"]
                                                        .toUpperCase() ==
                                                    "SCHEDULED"
                                                ? AppColors.orangeColor
                                                : AppColors.greenColor
                                            : null,
                                        chipLabel: teamMember["status"] != null
                                            ? teamMember["status"].toUpperCase()
                                            : null,
                                        hasDivider: teamMember ==
                                                leaveTeamCalendarData[
                                                    leaveTeamCalendarData
                                                            .length -
                                                        1]
                                            ? false
                                            : true,
                                      ))
                                  .toList(),
                            ),
                            padding(20.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "leave"),
      ),
    );
  }
}
