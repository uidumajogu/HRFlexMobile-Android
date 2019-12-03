import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';

Widget employeeDetails(
    Map<String, dynamic> employeeDetails, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: sw(8.0), vertical: sw(20.0)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.all(
        Radius.circular(sw(10.0)),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(
        sw(30.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Employee Details",
                    style: TextStyle(
                      fontSize: sf(12.0),
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  if (employeeDetails["name"] != null)
                    Text(
                      employeeDetails["name"],
                      style: TextStyle(
                          fontSize: sf(18.0),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                ],
              ),
              if (employeeDetails["image"] != null)
                imageBytes(
                  employeeDetails["image"],
                  sw(40.0),
                  sw(40.0),
                  false,
                ),
            ],
          ),
          padding(10.0),
          if (employeeDetails["designation"] != null)
            InfoWidget(
              description: "Designation",
              text: employeeDetails["designation"],
              hasDivider: true,
            ),
          if (employeeDetails["email"] != null)
            InfoWidget(
              description: "Email",
              text: employeeDetails["email"],
              image: InkWell(
                child: image(
                    "assets/images/sendEmail.png", 25.0, AppColors.accentColor),
                onTap: () {
                  Navigator.pop(context);
                  openEmail(employeeDetails["email"]);
                },
              ),
              hasDivider: true,
            ),
          if (employeeDetails["location"] != null)
            InfoWidget(
              description: "Office Location",
              text: employeeDetails["location"],
            ),
        ],
      ),
    ),
  );
}
