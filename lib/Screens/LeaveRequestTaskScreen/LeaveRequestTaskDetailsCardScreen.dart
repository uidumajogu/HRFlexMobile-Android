import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/EmployeeDetails.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';
import 'package:hr_flex/Common/MyCircularProgressIndicator.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/ButtonWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveTextField.dart';
import 'package:hr_flex/Screens/LeaveRequestTaskScreen/ChangeLeaveDaysForm.dart';

class LeaveRequestTaskDetailsCardScreen extends StatefulWidget {
  final Map<dynamic, dynamic> leaveTaskData;

  LeaveRequestTaskDetailsCardScreen({
    @required this.leaveTaskData,
  });

  @override
  _LeaveRequestTaskDetailsCardScreenState createState() =>
      _LeaveRequestTaskDetailsCardScreenState();
}

class _LeaveRequestTaskDetailsCardScreenState
    extends State<LeaveRequestTaskDetailsCardScreen> {
  String _leaveApprovalComment;
  bool _changedRequestedLeaveDate;
  String _newLeaveDays;
  bool _approvalStatus;
  String _commentErrorMessage;
  Map<dynamic, dynamic> _leaveApplicationStatusInformation;
  ApiUtil _apiUtil;
  final String leaveURL = APIpathUtil.baseURL + APIpathUtil.leavePATH;
  final Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  bool _showLoadingIndicator;

  @override
  void initState() {
    super.initState();
    _leaveApprovalComment = "";
    _changedRequestedLeaveDate = false;
    _commentErrorMessage = null;
    _newLeaveDays = widget.leaveTaskData["days"].toString();
    _leaveApplicationStatusInformation = {};
    _apiUtil = new ApiUtil();
    _approvalStatus = false;
    _showLoadingIndicator = false;
  }

  _onChangeLeaveApprovalComment(comment) {
    _leaveApprovalComment = comment;
    if (_commentErrorMessage != null) {
      setState(() {
        _commentErrorMessage = null;
      });
    }
  }

  bool _enteredLeaveApprovalComment(comment) {
    _leaveApprovalComment = comment;

    if (_leaveApprovalComment == "") {
      setState(() {
        _commentErrorMessage = "The comment field is required";
      });
      return false;
    }

    return true;
  }

  _updateLeaveDays(_isLeaveDaysChanged, _changedLeaveDays) {
    if (_isLeaveDaysChanged) {
      setState(() {
        _newLeaveDays = _changedLeaveDays;
        _changedRequestedLeaveDate = true;
      });
    }
  }

  _approveLeaveApplicationConfirmationDialog(status) {
    confirmationAlert(
        context,
        "You are about to ${status ? "APPROVE" : "DECLINE"} the ${widget.leaveTaskData["type"]} Leave for ${widget.leaveTaskData["employee"]["name"]}. Continue?",
        (c) => _checkApproveLeaveApplicationConfirmationDialog(c));
  }

  _checkApproveLeaveApplicationConfirmationDialog(confirmed) {
    if (confirmed) {
      _approveLeaveApplication(confirmed);
    }
  }

  _approveLeaveApplication(confirmed) {
    if (confirmed) {
      setState(() {
        _showLoadingIndicator = true;
      });
      _leaveApplicationStatusInformation = {};

      _leaveApplicationStatusInformation["days"] = int.parse(_newLeaveDays);
      _leaveApplicationStatusInformation["isApproved"] = _approvalStatus;
      _leaveApplicationStatusInformation["comments"] = _leaveApprovalComment;

      headers["authorization"] =
          APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];

      _apiUtil
          .patch(leaveURL + "tasks/" + widget.leaveTaskData["id"].toString(),
              headers: headers, body: _leaveApplicationStatusInformation)
          .then((dynamic res) {
        if (res["response"] == "Error") {
          setState(() {
            _showLoadingIndicator = false;
          });
          errorAlert(context, res["reason"]);
        } else {
          setState(() {
            _showLoadingIndicator = false;
          });
          successAlert(context,
              "${widget.leaveTaskData["type"]} Leave for ${widget.leaveTaskData["employee"]["name"]} has been updated successfuly!");
          Navigator.of(context).pop();
          setAsRootScreen(context, "/LeaveRequestTaskScreen");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _employeeData = widget.leaveTaskData["employee"];
    var _employeeReliefOfficerData = widget.leaveTaskData["reliefOfficer"];

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(sh(10)),
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(sh(10.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(sw(20.0)),
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
                              sh(40.0),
                              sh(40.0),
                              false,
                            ),
                            onTap: () => modalBottomSheetMenu(
                              context,
                              employeeDetails(_employeeData, context),
                            ),
                          ),
                          hasDivider: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Leave Type",
                                  style: TextStyle(
                                    color: AppColors.greyColor.withOpacity(0.8),
                                    fontSize: sf(11.0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                padding(5.0),
                                Text(
                                  "${widget.leaveTaskData["type"]}",
                                  style: TextStyle(
                                    color: AppColors.darkGreyColor,
                                    fontSize: sf(12.0),
                                  ),
                                ),
                                padding(5.0),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: sh(15)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 0.5,
                                      color:
                                          AppColors.greyColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                        color: AppColors.greyColor
                                            .withOpacity(0.8),
                                        fontSize: sf(11.0),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    padding(5.0),
                                    Text(
                                      "${DateUtil().format("MMMMd", DateTime.parse(widget.leaveTaskData["startDate"]))} - ${DateUtil().format("MMMMd", DateTime.parse(widget.leaveTaskData["endDate"]))}",
                                      style: TextStyle(
                                        color: AppColors.darkGreyColor,
                                        fontSize: sf(12.0),
                                      ),
                                    ),
                                    padding(5.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                        InfoWidget(
                          description: "Relief Officer",
                          text: _employeeReliefOfficerData["name"],
                          image: InkWell(
                            child: imageBytes(
                              _employeeReliefOfficerData["image"],
                              sw(40.0),
                              sw(40.0),
                              false,
                            ),
                            onTap: () => modalBottomSheetMenu(
                              context,
                              employeeDetails(
                                  _employeeReliefOfficerData, context),
                            ),
                          ),
                          hasDivider: true,
                        ),
                        InfoWidget(
                          description: _changedRequestedLeaveDate
                              ? "Pre-approved days"
                              : "Leave Days",
                          text: int.parse(_newLeaveDays) > 1
                              ? "$_newLeaveDays Days"
                              : "$_newLeaveDays Day",
                          suffixWidget: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(sh(10.0)),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontSize: sf(12),
                                ),
                              ),
                            ),
                            onTap: () => modalBottomSheetMenu(
                              context,
                              ChangeLeaveDaysForm(
                                leaveTaskData: widget.leaveTaskData,
                                submitLeaveDays: (c, v) =>
                                    _updateLeaveDays(c, v),
                              ),
                            ),
                          ),
                          hasDivider: false,
                        ),
                        padding(5),
                        if (_changedRequestedLeaveDate)
                          Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/ellipse.svg",
                                color: AppColors.brownColor,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: sh(8.0),
                                ),
                                child: Text(
                                  "REQUESTED: ${widget.leaveTaskData["days"]} DAYS",
                                  style: TextStyle(
                                    color: AppColors.lightPrimaryColor,
                                    fontSize: sf(10),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        padding(10.0),
                        LeaveTextField(
                          labelText: "Comment",
                          textInputType: TextInputType.text,
                          onSubmitted: (v) => _enteredLeaveApprovalComment(v),
                          textInputErrorMessage: _commentErrorMessage,
                          onChange: (v) => _onChangeLeaveApprovalComment(v),
                          textFieldHeight: 2,
                        ),
                        padding(20.0),
                        if (_showLoadingIndicator)
                          Container(
                            alignment: Alignment.center,
                            child: MyCircularProgressIndicator(
                              size: 40.0,
                              strokeWidth: 2.5,
                            ),
                          ),
                        if (!_showLoadingIndicator)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: ButtonWidget(
                                  label: "Approve",
                                  function: () {
                                    if (_enteredLeaveApprovalComment(
                                        _leaveApprovalComment)) {
                                      setState(() {
                                        _approvalStatus = true;
                                      });
                                      _approveLeaveApplicationConfirmationDialog(
                                          true);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(sh(10)),
                              ),
                              Flexible(
                                child: ButtonWidget(
                                  label: "Decline",
                                  labelColor: AppColors.primaryColor,
                                  backgroundColor: AppColors.whiteColor,
                                  borderColor: AppColors.accentColor,
                                  function: () {
                                    if (_enteredLeaveApprovalComment(
                                        _leaveApprovalComment)) {
                                      setState(() {
                                        _approvalStatus = false;
                                      });
                                      _approveLeaveApplicationConfirmationDialog(
                                          false);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        padding(10),
                      ],
                    ),
                  ),
                ),
                padding(10),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigation(context, "leave"),
      ),
    );
  }
}
