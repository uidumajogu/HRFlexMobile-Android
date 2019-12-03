import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/ButtonWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveTextField.dart';

class LeaveSupportInformationCard extends StatelessWidget {
  final Map<dynamic, dynamic> leaveTypeData;
  final Widget leaveApplicationStepperWidget;
  final String leaveDuration;
  final Function(String email) submitEmail;
  final String emailErrorMessage;
  final Function(String email) emailInputChange;
  final Function(String contactAdress) contactAddressInputChange;
  final String contactAddressErrorMessage;
  final Function(String contactAddress) submitContactAddress;
  final Function(String comment) commentInputChange;
  final String commentErrorMessage;
  final Function(String comment) submitComment;
  final Function(String phonenumber) contactPhonenumberInputChange;
  final String contactPhonenumberErrorMessage;
  final Function(String phonenumber) submitContactPhonenumber;
  final Function function;
  final Function addReliefOfficerChange;
  final String leaveDays;
  final Map<dynamic, dynamic> reliefOfficerData;
  final bool addReliefOfficerErrorMessage;

  LeaveSupportInformationCard({
    @required this.leaveTypeData,
    @required this.leaveApplicationStepperWidget,
    @required this.leaveDuration,
    @required this.submitEmail,
    @required this.emailErrorMessage,
    @required this.emailInputChange,
    @required this.submitContactAddress,
    @required this.contactAddressErrorMessage,
    @required this.contactAddressInputChange,
    @required this.submitComment,
    @required this.commentErrorMessage,
    @required this.commentInputChange,
    @required this.submitContactPhonenumber,
    @required this.contactPhonenumberErrorMessage,
    @required this.contactPhonenumberInputChange,
    @required this.function,
    @required this.leaveDays,
    @required this.reliefOfficerData,
    @required this.addReliefOfficerErrorMessage,
    @required this.addReliefOfficerChange,
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
                        "Provide Support Information",
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
                              "Days",
                              style: TextStyle(
                                color: AppColors.greyColor.withOpacity(0.8),
                                fontSize: sf(12.0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            padding(5.0),
                            Text(
                              "$leaveDays Working Days",
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
              padding(20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                child: Column(
                  children: <Widget>[
                    reliefOfficerData.isEmpty
                        ? ButtonWidget(
                            label: "Add Relief Officer",
                            icon: SvgPicture.asset(
                              "assets/images/worker.svg",
                              color: AppColors.accentColor,
                            ),
                            function: addReliefOfficerChange,
                          )
                        : InkWell(
                            child: PeopleWidget(
                              name: reliefOfficerData["name"],
                              description: reliefOfficerData["designation"],
                              image: imageBytes(
                                reliefOfficerData["image"],
                                sh(60.0),
                                sh(60.0),
                                false,
                              ),
                              suffixWidget: SvgPicture.asset(
                                "assets/images/chevronright.svg",
                                color: AppColors.lightGreyColor,
                              ),
                            ),
                            onTap: () =>
                                pushScreen(context, "/ReliefOfficersScreen"),
                          ),
                    if (addReliefOfficerErrorMessage)
                      Padding(
                        padding: EdgeInsets.all(sh(8.0)),
                        child: Text(
                          "Relief officer is required",
                          style: TextStyle(
                              color: AppColors.dangerColor, fontSize: sf(14)),
                        ),
                      ),
                    padding(20.0),
                    LeaveTextField(
                      labelText: "Contact Email",
                      textInputType: TextInputType.emailAddress,
                      onSubmitted: (v) => submitEmail(v),
                      textInputErrorMessage: emailErrorMessage,
                      onChange: (v) => emailInputChange(v),
                    ),
                    padding(10.0),
                    LeaveTextField(
                      labelText: "Contact PhoneNumber",
                      textInputType: TextInputType.number,
                      onSubmitted: (v) => submitContactPhonenumber(v),
                      textInputErrorMessage: contactPhonenumberErrorMessage,
                      onChange: (v) => contactPhonenumberInputChange(v),
                    ),
                    padding(10.0),
                    LeaveTextField(
                      labelText: "Contact Address",
                      textInputType: TextInputType.text,
                      onSubmitted: (v) => submitContactAddress(v),
                      textInputErrorMessage: contactAddressErrorMessage,
                      onChange: (v) => contactAddressInputChange(v),
                      textFieldHeight: 4,
                    ),
                    padding(10.0),
                    LeaveTextField(
                      labelText: "Comment",
                      textInputType: TextInputType.text,
                      onSubmitted: (v) => submitComment(v),
                      textInputErrorMessage: commentErrorMessage,
                      onChange: (v) => commentInputChange(v),
                      textFieldHeight: 2,
                    ),
                    padding(20.0),
                    ButtonWidget(
                      label: "Continue",
                      icon: SvgPicture.asset(
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
