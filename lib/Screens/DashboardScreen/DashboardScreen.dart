// This is the dashboard screen stateful class

import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

import 'package:hr_flex/Data/EmployeeData.dart';
import 'package:hr_flex/Data/LeaveData.dart';

import 'package:hr_flex/Screens/BirthDayScreen/BirthdayScreen.dart';
import 'package:hr_flex/Screens/DashboardScreen/DashboardHeader.dart';

import 'package:hr_flex/Screens/DashboardScreen/NewHiresCard.dart';
import 'package:hr_flex/Screens/DashboardScreen/ProfileCard.dart';
import 'package:hr_flex/Screens/NewHireScreen/NewHireScreen.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';

import 'BirthdayCard.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading;

  _pushScreenWithData(Widget screen) {
    pushScreenWithData(context, screen);
  }

  _logout(int value) {
    logout(context);
  }

  // This instantiates the dashboard screen properties
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    if (EmployeeData.employeeProfile == null) {
      EmployeeData().getEmployeeProfile().then((res) {
        EmployeeData().getEmployeeBirthdaysToday().then((res) {
          EmployeeData().getNewHires().then((res) {
            LeaveData().getEmployeeLeaveTasks().then((res) {
              setState(() {
                _isLoading = false;
              });
            });
          });
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  // This is the main dashboard screen UI widget
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
                          "Getting your profile...",
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
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: DeviceConfig.screenWidth,
                      height: DeviceConfig.screenHeight * 0.36,
                      color: AppColors.primaryColor,
                    ),
                    Container(
                      margin: EdgeInsets.all(sw(8.0)),
                      child: Column(
                        children: <Widget>[
                          padding(30.0),
                          DashboardHeader(
                            onTap: (w) => modalBottomSheetMenu(context, w),
                            logout: (v) => _logout(v),
                          ),
                          padding(18.0),
                          ProfileCard(
                            onTap: (w) => modalBottomSheetMenu(context, w),
                          ),
                          // padding(8.0),
                          // LeaveCard(goToLeaveActivity: _goToLeaveActivity),
                          padding(8.0),
                          BirthdayCard(
                            goToBirthdays: (bl) {
                              _pushScreenWithData(
                                BirthdayScreen(
                                  birthdaysTodayList: bl,
                                ),
                              );
                            },
                            onTap: (w) => modalBottomSheetMenu(context, w),
                          ),
                          padding(8.0),
                          NewHiresCard(
                            goToNewHires: (nhl) {
                              _pushScreenWithData(
                                NewHireScreen(
                                  newHireList: nhl,
                                ),
                              );
                            },
                            onTap: (w) => modalBottomSheetMenu(context, w),
                          ),
                          padding(8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "dashboard"),
      ),
    );
  }
}
