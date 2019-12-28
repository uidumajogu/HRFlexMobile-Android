import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Common/MyCircularProgressIndicator.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/ButtonWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveDatePickerTextField.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveTextField.dart';

class StartLeaveApplicationCard extends StatelessWidget {
  final Map<dynamic, dynamic> leaveTypeData;
  final Widget leaveApplicationStepperWidget;
  final Function function;
  final Function(String selectedLeaveDays) leaveDays;
  final Function(String selectedStartDate) startDate;
  final String dateErrorText;
  final String leaveDaysErrorMessage;
  final Function(String change) onChangeLeaveDays;
  final String initialLeaveDate;
  final String intiialLeaveDays;
  final bool showIndicator;

  StartLeaveApplicationCard({
    @required this.leaveTypeData,
    @required this.leaveApplicationStepperWidget,
    @required this.function,
    @required this.leaveDays,
    @required this.startDate,
    @required this.dateErrorText,
    @required this.leaveDaysErrorMessage,
    @required this.onChangeLeaveDays,
    @required this.initialLeaveDate,
    @required this.intiialLeaveDays,
    this.showIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
          padding: EdgeInsets.all(sw(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Apply for Leave",
                        style: TextStyle(
                          fontSize: sf(12.0),
                          color: AppColors.brownColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding(5.0),
                      Text(
                        leaveTypeData["type"],
                        style: TextStyle(
                          fontSize: sf(18.0),
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  leaveApplicationStepperWidget,
                ],
              ),
              padding(10.0),
              InfoWidget(
                description: "Year",
                text: leaveTypeData["financialYear"] != null
                    ? leaveTypeData["financialYear"]
                    : "Not Available",
                hasDivider: true,
              ),
              InfoWidget(
                description: "Leave Limit",
                text: leaveTypeData["maximum"] != null
                    ? "${leaveTypeData["maximum"].toString()} ${leaveTypeData["mode"].toString()}"
                    : "Not Available",
                hasDivider: true,
              ),
              // InfoWidget(
              //   description: "Earned Days",
              //   text: leaveTypeData["earned"] != null
              //       ? "${leaveTypeData["earned"].toString()} Days"
              //       : "Not Available",
              //   hasDivider: true,
              // ),
              InfoWidget(
                description: "Days Left",
                text: leaveTypeData["available"] != null
                    ? "${leaveTypeData["available"].toString()} ${leaveTypeData["mode"].toString()}"
                    : "Not Available",
                hasDivider: false,
              ),
              padding(20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                child: LeaveDatePickerTextField(
                  startDate: (v) => startDate(v),
                  dateErrorText: dateErrorText,
                  initialValue: initialLeaveDate,
                  lastDate: "${leaveTypeData["maximumStartDate"]}",
                ),
              ),
              padding(10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                child: LeaveTextField(
                  onSubmitted: (v) => leaveDays(v),
                  textInputErrorMessage: leaveDaysErrorMessage,
                  onChange: (v) => onChangeLeaveDays(v),
                  labelText: 'Number of Days',
                  textInputType: TextInputType.number,
                  enabled: leaveTypeData["canSplit"] ? "true" : "false",
                  initialValue: leaveTypeData["canSplit"]
                      ? intiialLeaveDays
                      : leaveTypeData["available"].toString(),
                ),
              ),
              padding(25.0),
              if (showIndicator)
                Container(
                  alignment: Alignment.center,
                  child: MyCircularProgressIndicator(
                    size: 40.0,
                    strokeWidth: 2.5,
                  ),
                ),

              if (!showIndicator)
                ButtonWidget(
                  label: "Continue",
                  suffixIcon: SvgPicture.asset(
                    "assets/images/chevronright.svg",
                    color: AppColors.accentColor,
                  ),
                  function: function,
                ),
            ],
          )),
    );
  }
}
