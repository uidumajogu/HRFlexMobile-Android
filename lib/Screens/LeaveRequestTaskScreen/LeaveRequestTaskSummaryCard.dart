import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Screens/LeaveRequestTaskScreen/LeaveRequestTaskDetailsCardScreen.dart';

class LeaveRequestTaskSummaryCard extends StatelessWidget {
  final Map<dynamic, dynamic> leaveTaskData;

  LeaveRequestTaskSummaryCard({
    @required this.leaveTaskData,
  });
  @override
  Widget build(BuildContext context) {
    var _employeeData = leaveTaskData["employee"];

    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sh(10.0)),
          ),
          child: Padding(
            padding: EdgeInsets.all(sw(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PeopleWidget(
                  name: _employeeData["name"],
                  description: _employeeData["designation"],
                  image: InkWell(
                    child: imageBytes(
                      _employeeData["image"],
                      sh(60.0),
                      sh(60.0),
                      false,
                    ),
                    onTap: () => modalBottomSheetMenu(
                      context,
                      employeeDetails(_employeeData, context),
                    ),
                  ),
                  hasDivider: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sh(15.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Leave Type",
                            style: TextStyle(
                              color: AppColors.greyColor.withOpacity(0.8),
                              fontSize: sf(12.0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          padding(5.0),
                          Text(
                            "${leaveTaskData["type"]}",
                            style: TextStyle(
                              color: AppColors.darkGreyColor,
                              fontSize: sf(14.0),
                            ),
                          ),
                          padding(10.0),
                        ],
                      ),
                      Flexible(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: sh(15)),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 0.5,
                                  color: AppColors.greyColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                        color: AppColors.greyColor
                                            .withOpacity(0.8),
                                        fontSize: sf(12.0),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    padding(5.0),
                                    Text(
                                      "${DateUtil().format("MMMMd", DateTime.parse(leaveTaskData["startDate"]))} - ${DateUtil().format("MMMMd", DateTime.parse(leaveTaskData["endDate"]))}",
                                      style: TextStyle(
                                        color: AppColors.darkGreyColor,
                                        fontSize: sf(14.0),
                                      ),
                                    ),
                                    padding(10.0),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: sh(15.0)),
                                  child: SvgPicture.asset(
                                    "assets/images/chevronright.svg",
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => {
                            pushScreenWithData(
                              context,
                              LeaveRequestTaskDetailsCardScreen(
                                leaveTaskData: leaveTaskData,
                              ),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        padding(10),
      ],
    );
  }
}
