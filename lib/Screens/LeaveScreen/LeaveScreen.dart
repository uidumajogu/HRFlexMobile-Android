import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/LeaveData.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveApplicationScreen.dart';
import 'package:hr_flex/Screens/LeaveScreen/LeaveTypesCard.dart';
import 'package:hr_flex/Screens/LeaveScreen/VacationActivityCard.dart';

class LeaveScreen extends StatefulWidget {
  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  bool _isLoading;

  goToLeaveApplication(x) {
    pushScreenWithData(
      context,
      LeaveApplicationScreen(
        leaveTypeData: x,
      ),
    );
  }

  // This instantiates the leave screen properties
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    LeaveData().getLeaveTypes().then((res) {
      LeaveData().getEmployeeLeaveCalendar().then((res) {
        LeaveData().getEmployeeLeaveTeamCalendar().then((res) {
          LeaveData().getEmployeeLeaveTasks().then((res) {
            setState(() {
              _isLoading = false;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: sw(8.0)),
                    child: Text(
                      "Leave Management",
                      style: TextStyle(
                        fontSize: sf(20.0),
                      ),
                    ),
                  ),
                  Text(
                    "Manage your Leave Request",
                    style: TextStyle(
                      fontSize: sf(10.0),
                      color: AppColors.lightColor.withOpacity(0.9),
                    ),
                  )
                ],
              ),
              if (!_isLoading)
                InkWell(
                  child: Stack(
                    children: <Widget>[
                      if (LeaveData.employeeLeaveTasks.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                            left: sh(30.0),
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
                      Container(
                        height: sh(40.0),
                        width: sh(40.0),
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
                    ],
                  ),
                  onTap: () {
                    if (LeaveData.employeeLeaveTasks.isNotEmpty) {
                      pushScreen(context, "/LeaveRequestTaskScreen");
                    }
                  },
                )
            ],
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
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    padding(8.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                      child: VacationActivityCard(
                        onTap: (w) => modalBottomSheetMenu(context, w),
                        viewTeamCalendar: () =>
                            pushScreen(context, "/TeamLeaveCalendarScreen"),
                      ),
                    ),
                    padding(8.0),
                    SizedBox(
                      height: DeviceConfig.screenWidth * 0.6,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: LeaveData.leaveTypes
                            .map<Widget>((leaveType) => LeaveTypesCard(
                                leaveTypeData: leaveType,
                                lastCard: leaveType ==
                                    LeaveData.leaveTypes[
                                        LeaveData.leaveTypes.length - 1],
                                goToLeaveApplication: (x) =>
                                    goToLeaveApplication(x)))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "leave"),
      ),
    );
  }
}
