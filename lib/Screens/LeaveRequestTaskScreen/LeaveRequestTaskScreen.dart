import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/LeaveData.dart';
import 'package:hr_flex/Screens/LeaveRequestTaskScreen/LeaveRequestTaskSummaryCard.dart';

class LeaveRequestTaskScreen extends StatefulWidget {
  @override
  _LeaveRequestTaskScreenState createState() => _LeaveRequestTaskScreenState();
}

class _LeaveRequestTaskScreenState extends State<LeaveRequestTaskScreen> {
  bool _isLoading;
  List<dynamic> _employeeLeaveTasks;

  // This instantiates the leave request screen properties
  @override
  void initState() {
    super.initState();

    _isLoading = true;

    LeaveData().getEmployeeLeaveTasks().then((res) {
      setState(() {
        _employeeLeaveTasks = LeaveData.employeeLeaveTasks;
        _isLoading = false;
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
              Padding(
                padding: EdgeInsets.only(right: sw(8.0)),
                child: Text(
                  "Leave Requests",
                  style: TextStyle(
                    fontSize: sf(20.0),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Container(
          child: _isLoading
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
                            "Getting your leave tasks...",
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
              : Container(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: sh(15)),
                      width: DeviceConfig.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          padding(sh(20)),
                          Column(
                            children: _employeeLeaveTasks
                                .map<Widget>((taskData) =>
                                    LeaveRequestTaskSummaryCard(
                                        leaveTaskData: taskData))
                                .toList(),
                          ),
                          padding(sh(20)),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "leave"),
      ),
    );
  }
}
