import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Common/NoData.dart';
import 'package:hr_flex/Data/EmployeeData.dart';

class ProfileCard extends StatelessWidget {
  final Function(Widget w) onTap;

  ProfileCard({
    this.onTap,
  });
  final Map<String, dynamic> _employeeProfileData =
      EmployeeData.employeeProfile;

  final Map<String, dynamic> _managerProfileData =
      EmployeeData.employeeProfile["manager"];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sw(15.0)),
        child: _employeeProfileData.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InfoWidget(
                    description: "Hire Date",
                    text: _employeeProfileData["hireDate"] != null
                        ? _employeeProfileData["hireDate"]
                        : "not available",
                    chipColor: _employeeProfileData["isConfirmed"] != null
                        ? _employeeProfileData["isConfirmed"]
                            ? AppColors.greenColor
                            : AppColors.orangeColor
                        : null,
                    chipLabel: _employeeProfileData["isConfirmed"] != null
                        ? _employeeProfileData["isConfirmed"]
                            ? "CONFIRMED"
                            : "PROBATION"
                        : null,
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Grade",
                    text: _employeeProfileData["grade"] != null
                        ? _employeeProfileData["grade"]
                        : "not available",
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Location",
                    text: _employeeProfileData["location"] != null
                        ? _employeeProfileData["location"]
                        : "not available",
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Email",
                    text: _employeeProfileData["email"] != null
                        ? _employeeProfileData["email"]
                        : "not available",
                    hasDivider: true,
                  ),
                  InfoWidget(
                    description: "Phone Number",
                    text: _employeeProfileData["mobileNo"] != null
                        ? _employeeProfileData["mobileNo"]
                        : "not available",
                    hasDivider: _managerProfileData != null ? true : false,
                  ),
                  if (_managerProfileData != null)
                    InfoWidget(
                      description: "Line Manager",
                      text: _managerProfileData["name"] != null
                          ? _managerProfileData["name"]
                          : "name not available",
                      image: _managerProfileData["image"] != null
                          ? InkWell(
                              child: imageBytes(
                                _managerProfileData["image"],
                                sw(40.0),
                                sw(40.0),
                                false,
                              ),
                              onTap: () => onTap(
                                employeeDetails(_managerProfileData, context),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(0.0),
                            ),
                    ),
                ],
              )
            : NoData(msg: "No profile available"),
      ),
    );
  }
}
