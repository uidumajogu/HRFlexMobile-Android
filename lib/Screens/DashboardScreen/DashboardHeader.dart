import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/ClientData.dart';
import 'package:hr_flex/Data/EmployeeData.dart';
import 'package:hr_flex/Screens/DashboardScreen/OrganizationDetails.dart';

class DashboardHeader extends StatelessWidget {
  final Function(Widget w) onTap;
  final Function(int value) logout;

  DashboardHeader({
    this.onTap,
    this.logout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceConfig.screenHeight * 0.24,
      padding: EdgeInsets.symmetric(horizontal: sw(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          EmployeeData.employeeProfile.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    imageBytes(
                      EmployeeData.employeeProfile["image"],
                      sh(60.0),
                      sh(60.0),
                      true,
                    ),
                    padding(10.0),
                    if (EmployeeData.employeeProfile["name"] != null)
                      Text(
                        EmployeeData.employeeProfile["name"],
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: sf(20.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    padding(5.0),
                    if (EmployeeData.employeeProfile["designation"] != null)
                      Text(
                        EmployeeData.employeeProfile["designation"],
                        style: TextStyle(
                          color: AppColors.whiteColor.withOpacity(0.8),
                          fontSize: sf(14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (EmployeeData.employeeProfile["id"] != null)
                      Text(
                        "${EmployeeData.employeeProfile["id"]}",
                        style: TextStyle(
                          color: AppColors.whiteColor.withOpacity(0.8),
                          fontSize: sf(14.0),
                        ),
                      ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(5.0),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: sh(30.0)),
                child: simplePopup(
                  ["Logout"],
                  1,
                  context,
                  (v) => logout(v),
                ),
              ),
              ClientData.clientDetails.isNotEmpty
                  ? InkWell(
                      child: imageBytes(
                        ClientData.clientDetails["logo"],
                        sh(32.0),
                        sh(32.0),
                        false,
                      ),
                      onTap: () => onTap(organizationDetails(
                          ClientData.clientDetails, context)),
                    )
                  : Padding(
                      padding: EdgeInsets.all(sw(10.0)),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
