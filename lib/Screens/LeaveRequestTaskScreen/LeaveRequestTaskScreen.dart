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
  bool _toggleTabValue;
  Color _activeTabBorderColor;
  Color _activeTabTitleColor;
  Color _inactiveTabBorderColor;
  Color _inactiveTabTitleColor;
  List<dynamic> _employeeLeaveTasks;

  // This instantiates the leave request screen properties
  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _toggleTabValue = true;
    _activeTabBorderColor = AppColors.lightBlueColor;
    _inactiveTabBorderColor = AppColors.lightGreyColor;
    _activeTabTitleColor = AppColors.primaryColor;
    _inactiveTabTitleColor = AppColors.lightGreyColor;

    LeaveData().getEmployeeLeaveTasks().then((res) {
      setState(() {
        _employeeLeaveTasks = LeaveData.employeeLeaveTasks;
        _isLoading = false;
      });
    });
  }

  void toggleTab(value) {
    setState(() {
      _toggleTabValue = value;
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
                  padding: EdgeInsets.symmetric(horizontal: sh(15)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: sh(60),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _toggleTabValue
                                          ? _activeTabBorderColor
                                          : _inactiveTabBorderColor,
                                      width: _toggleTabValue ? sh(5) : sh(1),
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "SUBMITED",
                                  style: TextStyle(
                                    fontSize: sf(15),
                                    color: _toggleTabValue
                                        ? _activeTabTitleColor
                                        : _inactiveTabTitleColor,
                                  ),
                                ),
                              ),
                              onTap: () => toggleTab(true),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                                child: Container(
                                  height: sh(60),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: !_toggleTabValue
                                            ? _activeTabBorderColor
                                            : _inactiveTabBorderColor,
                                        width: !_toggleTabValue ? sh(5) : sh(1),
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "DIRECT REPORTS",
                                        style: TextStyle(
                                          fontSize: sf(15),
                                          color: !_toggleTabValue
                                              ? _activeTabTitleColor
                                              : _inactiveTabTitleColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: sh(8.0),
                                        ),
                                        child: Container(
                                          height: sh(30.0),
                                          width: sh(30.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: !_toggleTabValue
                                                  ? _activeTabTitleColor
                                                  : _inactiveTabTitleColor,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: EdgeInsets.all(sh(8.0)),
                                            child: Text(
                                              "${LeaveData.employeeLeaveTasks.length}",
                                              style: TextStyle(
                                                  fontSize: sh(10),
                                                  color: AppColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => toggleTab(false)),
                          ),
                        ],
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Container(
                            width: DeviceConfig.screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                padding(sh(20)),
                                if (!_toggleTabValue)
                                  Column(
                                    children: _employeeLeaveTasks
                                        .map<Widget>((taskData) =>
                                            LeaveRequestTaskSummaryCard(
                                                leaveTaskData: taskData))
                                        .toList(),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "leave"),
      ),
    );
  }
}
