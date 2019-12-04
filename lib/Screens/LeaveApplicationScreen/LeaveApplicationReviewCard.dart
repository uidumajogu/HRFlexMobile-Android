import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/ButtonWidget.dart';

class LeaveApplicationReviewCard extends StatelessWidget {
  final Map<dynamic, dynamic> leaveTypeData;
  final Widget leaveApplicationStepperWidget;
  final String leaveDuration;
  final String contactAddress;
  final String resumptionDate;
  final String phoneNumber;
  final String comments;
  final String leaveDays;
  final Map<dynamic, dynamic> reliefOfficerData;
  final Function function;

  LeaveApplicationReviewCard({
    @required this.leaveTypeData,
    @required this.leaveApplicationStepperWidget,
    @required this.leaveDuration,
    @required this.contactAddress,
    @required this.resumptionDate,
    @required this.phoneNumber,
    @required this.comments,
    @required this.function,
    @required this.leaveDays,
    @required this.reliefOfficerData,
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
                        leaveTypeData["type"],
                        style: TextStyle(
                          fontSize: sf(14.0),
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding(5.0),
                      Text(
                        "Preview",
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
              padding(20.0),
              Column(
                children: <Widget>[
                  padding(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Duration",
                              style: TextStyle(
                                color: AppColors.greyColor.withOpacity(0.8),
                                fontSize: sf(12.0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            padding(5.0),
                            Text(
                              leaveDuration,
                              style: TextStyle(
                                color: AppColors.darkGreyColor,
                                fontSize: sf(14.0),
                              ),
                            ),
                            Text(
                              int.parse(leaveDays) < 2
                                  ? "$leaveDays Working Day"
                                  : "$leaveDays Working Days",
                              style: TextStyle(
                                color: AppColors.lightPrimaryColor,
                                fontSize: sf(12.0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            padding(10.0),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: sh(15)),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: 0.5,
                                    color:
                                        AppColors.greyColor.withOpacity(0.5)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Resumption Date",
                              style: TextStyle(
                                color: AppColors.greyColor.withOpacity(0.8),
                                fontSize: sf(12.0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            padding(5.0),
                            Text(
                              resumptionDate,
                              style: TextStyle(
                                color: AppColors.darkGreyColor,
                                fontSize: sf(14.0),
                              ),
                            ),
                            padding(10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.greyColor.withOpacity(0.5),
                  ),
                ],
              ),
              padding(10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                child: Column(
                  children: <Widget>[
                    InfoWidget(
                      description: "Relief Officer",
                      text: reliefOfficerData["name"],
                      image: InkWell(
                        child: imageBytes(
                          reliefOfficerData["image"],
                          sw(60.0),
                          sw(60.0),
                          false,
                        ),
                        onTap: () => modalBottomSheetMenu(
                          context,
                          employeeDetails(reliefOfficerData, context),
                        ),
                      ),
                      hasDivider: true,
                    ),
                    padding(5.0),
                    InfoWidget(
                      description: "House Address",
                      text: contactAddress,
                      hasDivider: true,
                    ),
                    padding(5.0),
                    InfoWidget(
                      description: "Phone Number",
                      text: phoneNumber,
                      hasDivider: true,
                    ),
                    padding(5.0),
                    InfoWidget(
                      description: "Comments",
                      text: comments,
                      hasDivider: false,
                    ),
                    padding(20.0),
                    ButtonWidget(
                      label: "Submit Request",
                      suffixIcon: SvgPicture.asset(
                        "assets/images/chevronright.svg",
                        color: AppColors.accentColor,
                      ),
                      function: function,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
