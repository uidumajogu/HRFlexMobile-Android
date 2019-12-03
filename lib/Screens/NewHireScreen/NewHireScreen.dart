import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';

import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';

class NewHireScreen extends StatefulWidget {
  final List<dynamic> newHireList;

  NewHireScreen({
    @required this.newHireList,
  });

  @override
  _NewHireScreenState createState() => _NewHireScreenState();
}

class _NewHireScreenState extends State<NewHireScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "New Hires",
            style: TextStyle(
              fontSize: sf(20.0),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(15.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              padding(20.0),
              Text(
                "Week starting ${DateUtil().format("MMMMd", DateUtil().recentMonday())}",
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
                        children: widget.newHireList
                            .map<Widget>((nhl) => PeopleWidget(
                                  name: nhl["name"],
                                  description: nhl["designation"],
                                  description2: nhl["hireDate"],
                                  image: InkWell(
                                    child: imageBytes(
                                      nhl["image"],
                                      sh(60.0),
                                      sh(60.0),
                                      false,
                                    ),
                                    onTap: () => modalBottomSheetMenu(
                                      context,
                                      employeeDetails(nhl, context),
                                    ),
                                  ),
                                  hasDivider: nhl ==
                                          widget.newHireList[
                                              widget.newHireList.length - 1]
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
        bottomNavigationBar: bottomNavigation(context, "dashboard"),
      ),
    );
  }
}
