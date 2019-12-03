import 'package:flutter/material.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';

class BirthdayScreen extends StatefulWidget {
  final List<dynamic> birthdaysTodayList;

  BirthdayScreen({
    @required this.birthdaysTodayList,
  });
  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Birthdays",
            style: TextStyle(
              fontSize: sf(20.0),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: sh(15.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              padding(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateUtil().format("MMMMd", DateUtil().now),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: sf(18.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "records ${widget.birthdaysTodayList.length}",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: sf(14.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              padding(10.0),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: widget.birthdaysTodayList
                            .map<Widget>((bdt) => PeopleWidget(
                                  name: bdt["name"],
                                  description: bdt["designation"],
                                  description2: bdt["email"],
                                  image: InkWell(
                                    child: imageBytes(
                                      bdt["image"],
                                      sh(60.0),
                                      sh(60.0),
                                      false,
                                    ),
                                    onTap: () => modalBottomSheetMenu(
                                      context,
                                      employeeDetails(bdt, context),
                                    ),
                                  ),
                                  hasDivider: bdt ==
                                          widget.birthdaysTodayList[
                                              widget.birthdaysTodayList.length -
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
        bottomNavigationBar: bottomNavigation(context, "dashboard"),
      ),
    );
  }
}
