import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/LeaveData.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveApplicationReviewCard.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveApplicationStepperWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveSupportInformationCard.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/StartLeaveApplicationCard.dart';
import 'package:path/path.dart' as path;

class LeaveApplicationScreen extends StatefulWidget {
  final Map<dynamic, dynamic> leaveTypeData;

  LeaveApplicationScreen({
    @required this.leaveTypeData,
  });

  @override
  _LeaveApplicationScreenState createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  int leaveApplicationIndex;
  String selectedLeaveDays;
  String selectedStartDate;
  String _dateErrorText;
  String _leaveDaysErrorMessage;
  String _contactAddressErrorText;
  String _contactAddress;
  String _contactPhonenumberErrorText;
  String _contactPhonenumber;
  String _commentErrorText;
  String _comment;
  String _leaveDuration;
  String _resumptionDate;
  bool _addReliefOfficerErrorMessage;
  String _addSupportingDocumentErrorMessage;
  String _supportingDocumentFileName;
  String _supportingDocumentFileBase64;
  bool _supportingDocumentUploaded;
  Map<dynamic, dynamic> _leaveApplicationInformation;
  Map<dynamic, dynamic> _supportingDocument;
  Map<dynamic, dynamic> _leaveDurationInformation;
  Map<dynamic, dynamic> _reliefOfficerData;
  ApiUtil _apiUtil;
  final String leaveURL = APIpathUtil.baseURL + APIpathUtil.leavePATH;
  final Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  final List<dynamic> _acceptableSupportDocumentExtensions = [
    "pdf",
    "jpg",
    "jpeg",
    "png"
  ];

  @override
  void initState() {
    super.initState();
    leaveApplicationIndex = 0;
    selectedLeaveDays = widget.leaveTypeData["canSplit"]
        ? ""
        : widget.leaveTypeData["available"].toString();
    selectedStartDate = "";
    _dateErrorText = null;
    _leaveDaysErrorMessage = null;
    _contactAddressErrorText = null;
    _contactAddress = "";
    _contactPhonenumberErrorText = null;
    _contactPhonenumber = "";
    _commentErrorText = null;
    _comment = "";
    _addReliefOfficerErrorMessage = false;
    _addSupportingDocumentErrorMessage = null;
    _reliefOfficerData = LeaveData().getReliefOfficerData();
    _leaveApplicationInformation = {};
    _leaveDurationInformation = {};
    _apiUtil = new ApiUtil();
    _supportingDocument = {};
    _leaveDuration = "";
    _resumptionDate = "";
    _supportingDocumentFileName = "";
    _supportingDocumentFileBase64 = "";
    _supportingDocumentUploaded = false;
  }

  _onChangeLeaveDays(v) {
    selectedLeaveDays = v;
    setState(() {
      _leaveDaysErrorMessage = null;
    });
  }

  bool _selectedLeaveDays(v) {
    selectedLeaveDays = v;

    if (selectedLeaveDays == "") {
      setState(() {
        _leaveDaysErrorMessage = "Select your leave start date";
      });
      return false;
    }

    if (int.parse(selectedLeaveDays) > widget.leaveTypeData["available"]) {
      setState(() {
        _leaveDaysErrorMessage =
            "Number of days entered cannot be greater than the remaining leave days left";
      });
      return false;
    }

    return true;
  }

  bool _selectedStartDate(v) {
    selectedStartDate = v;

    setState(() {
      _dateErrorText = null;
    });

    if (selectedStartDate == "") {
      setState(() {
        _dateErrorText = "Select your leave start date";
      });
      return false;
    }

    return true;
  }

  _contactPhonenumberOnChange(v) {
    _contactPhonenumber = v;
    setState(() {
      _contactPhonenumberErrorText = null;
    });
  }

  bool _enteredContactPhonenumber(v) {
    _contactPhonenumber = v;

    if (_contactPhonenumber == "") {
      setState(() {
        _contactPhonenumberErrorText = "Enter your contact phone number";
      });
      return false;
    }

    return true;
  }

  _contactAddressOnChange(v) {
    _contactAddress = v;
    setState(() {
      _contactAddressErrorText = null;
    });
  }

  bool _enteredContactAddress(v) {
    _contactAddress = v;

    if (_contactAddress == "") {
      setState(() {
        _contactAddressErrorText = "Enter your contact address";
      });
      return false;
    }

    return true;
  }

  _commentOnChange(v) {
    _comment = v;
    setState(() {
      _commentErrorText = null;
    });
  }

  bool _enteredComment(v) {
    _comment = v;

    return true;
  }

  _addReliefOfficerChange() {
    setState(() {
      _addReliefOfficerErrorMessage = false;
    });
    pushScreen(context, "/ReliefOfficersScreen");
  }

  bool _selectedReliefOfficer() {
    if (LeaveData().getReliefOfficerData().isEmpty) {
      setState(() {
        _addReliefOfficerErrorMessage = true;
      });
      return false;
    }

    return true;
  }

  void _uploadSupportingDocumentFunction() async {
    setState(() {
      _addSupportingDocumentErrorMessage = null;
      _supportingDocumentFileName = "";
      _supportingDocumentFileBase64 = "";
      _supportingDocumentUploaded = false;
    });

    try {
      String _filePath;
      String _fileName;
      String _fileExtension;
      var _fileBytes;
      bool isCorrectFileExtension = false;

      _filePath = await FilePicker.getFilePath(
        type: FileType.ANY,
        fileExtension: '',
      );

      if (_filePath != null) {
        _fileName = path.basename(_filePath);

        _fileExtension = path.extension(_filePath);

        _acceptableSupportDocumentExtensions.forEach((ext) {
          if (".$ext".toUpperCase() == _fileExtension.toUpperCase()) {
            _supportingDocumentFileName = _fileName;
            isCorrectFileExtension = true;
          }
        });

        if (isCorrectFileExtension) {
          _fileBytes = await File(_filePath).readAsBytes();
          setState(() {
            _supportingDocumentFileBase64 = base64Encode(_fileBytes);
            _supportingDocumentUploaded = true;
          });
        } else {
          setState(() {
            _addSupportingDocumentErrorMessage =
                "The file type is not supported, upload an image or PDF.";
          });
        }
      } else {
        setState(() {
          _addSupportingDocumentErrorMessage =
              "A supporting document is required. Upload supoorting document.";
        });
      }
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  bool _includedSupportingDocument() {
    print("documentRequired - - ${widget.leaveTypeData["documentRequired"]}");

    if (_supportingDocumentFileName == "" &&
        widget.leaveTypeData["documentRequired"]) {
      setState(() {
        _addSupportingDocumentErrorMessage =
            "A supporting document is required. Upload supoorting document.";
      });
      return false;
    }
    return true;
  }

  _nextLeaveApplicationStep(currentStep) {
    bool _canGoToNext = false;
    if (currentStep == 0) {
      _canGoToNext = _selectedStartDate(selectedStartDate) &&
          _selectedLeaveDays(selectedLeaveDays);
    }

    if (currentStep == 1) {
      _canGoToNext = _enteredContactPhonenumber(_contactPhonenumber) &&
          _enteredContactAddress(_contactAddress) &&
          _enteredComment(_comment) &&
          _selectedReliefOfficer() &&
          _includedSupportingDocument();
    }

    if (_canGoToNext) {
      if (currentStep == 0) {
        getLeaveDuration().then((res) {
          if (res) {
            setState(() {
              leaveApplicationIndex = currentStep + 1;
            });
          }
        });
      } else {
        setState(() {
          leaveApplicationIndex = currentStep + 1;
        });
      }
    }
  }

  Future<bool> _previousLeaveApplicationStep() {
    var _currentStep = leaveApplicationIndex;
    if (_currentStep != 0) {
      setState(() {
        leaveApplicationIndex = _currentStep - 1;
      });
      return Future.value(false);
    }

    return Future.value(true);
  }

  Future<bool> getLeaveDuration() {
    _leaveDurationInformation = {};

    _leaveDurationInformation["startDate"] = selectedStartDate;
    _leaveDurationInformation["days"] = int.parse(selectedLeaveDays);

    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];

    return _apiUtil
        .post(leaveURL + widget.leaveTypeData["id"].toString() + "/details",
            headers: headers, body: _leaveDurationInformation)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        errorAlert(context, res["reason"]);
        return false;
      } else {
        setState(() {
          _leaveDuration =
              "${DateUtil().format("MMMMd", DateTime.parse(res["details"]["startDate"]))} - ${DateUtil().format("MMMMd", DateTime.parse(res["details"]["endDate"]))}";

          _resumptionDate =
              "${DateUtil().format("MMMMd", DateTime.parse(res["details"]["resumptionDate"]))}";
        });

        return true;
      }
    });
  }

  submitLeaveApplication() {
    _leaveApplicationInformation = {};
    _supportingDocument = {};

    _supportingDocument["fileName"] = _supportingDocumentFileName;
    _supportingDocument["content"] = _supportingDocumentFileBase64;

    _leaveApplicationInformation["startDate"] = selectedStartDate;
    _leaveApplicationInformation["days"] = int.parse(selectedLeaveDays);
    _leaveApplicationInformation["reliefOfficerId"] = _reliefOfficerData["id"];
    _leaveApplicationInformation["supportingDocument"] = _supportingDocument;
    _leaveApplicationInformation["contactAddress"] = _contactAddress;
    _leaveApplicationInformation["contactPhone"] = _contactPhonenumber;
    _leaveApplicationInformation["comments"] = _comment;

    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];

    _apiUtil
        .post(leaveURL + widget.leaveTypeData["id"].toString(),
            headers: headers, body: _leaveApplicationInformation)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        errorAlert(context, res["reason"]);
      } else {
        successAlert(context,
            "Your ${widget.leaveTypeData["type"]} request has been submitted successfuly!");
        Navigator.of(context).pop();
        setAsRootScreen(context, "/LeaveScreen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _reliefOfficerData = LeaveData().getReliefOfficerData();
    return WillPopScope(
      onWillPop: _previousLeaveApplicationStep,
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Leave Application",
              style: TextStyle(
                fontSize: sf(20.0),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: sw(15.0), horizontal: sw(5.0)),
                child: leaveApplicationIndex == 0
                    ? StartLeaveApplicationCard(
                        leaveTypeData: widget.leaveTypeData,
                        leaveApplicationStepperWidget:
                            LeaveApplicationStepperWidget(
                          index: 0,
                          stepperLength: 3,
                        ),
                        function: () => _nextLeaveApplicationStep(0),
                        leaveDays: (v) => _selectedLeaveDays(v),
                        startDate: (v) => _selectedStartDate(v),
                        dateErrorText: _dateErrorText,
                        leaveDaysErrorMessage: _leaveDaysErrorMessage,
                        onChangeLeaveDays: (v) => _onChangeLeaveDays(v),
                        initialLeaveDate: selectedStartDate,
                        intiialLeaveDays: selectedLeaveDays,
                      )
                    : leaveApplicationIndex == 1
                        ? LeaveSupportInformationCard(
                            leaveTypeData: widget.leaveTypeData,
                            leaveApplicationStepperWidget:
                                LeaveApplicationStepperWidget(
                              index: 1,
                              stepperLength: 3,
                            ),
                            leaveDuration: _leaveDuration,
                            resumptionDate: _resumptionDate,
                            leaveDays: selectedLeaveDays,
                            submitContactAddress: (v) =>
                                _enteredContactAddress(v),
                            contactAddressErrorMessage:
                                _contactAddressErrorText,
                            contactAddressInputChange: (v) =>
                                _contactAddressOnChange(v),
                            commentInputChange: _commentOnChange,
                            submitComment: _enteredComment,
                            commentErrorMessage: _commentErrorText,
                            contactPhonenumberInputChange:
                                _contactPhonenumberOnChange,
                            submitContactPhonenumber:
                                _enteredContactPhonenumber,
                            contactPhonenumberErrorMessage:
                                _contactPhonenumberErrorText,
                            function: () => _nextLeaveApplicationStep(1),
                            reliefOfficerData: _reliefOfficerData,
                            addReliefOfficerErrorMessage:
                                _addReliefOfficerErrorMessage,
                            selectReliefOfficerFunction:
                                _addReliefOfficerChange,
                            initialComment: _comment,
                            initialContactAddress: _contactAddress,
                            initialContactPhoneNumber: _contactPhonenumber,
                            addSupportingDocumentErrorMessage:
                                _addSupportingDocumentErrorMessage,
                            uploadSupportingDocumentFunction:
                                _uploadSupportingDocumentFunction,
                            supportingDocumentUploaded:
                                _supportingDocumentUploaded,
                            supportingDocumentFileName:
                                _supportingDocumentFileName,
                          )
                        : leaveApplicationIndex == 2
                            ? LeaveApplicationReviewCard(
                                leaveTypeData: widget.leaveTypeData,
                                leaveApplicationStepperWidget:
                                    LeaveApplicationStepperWidget(
                                  index: 2,
                                  stepperLength: 3,
                                ),
                                leaveDuration: _leaveDuration,
                                resumptionDate: _resumptionDate,
                                leaveDays: selectedLeaveDays,
                                contactAddress: _contactAddress,
                                phoneNumber: _contactPhonenumber,
                                comments: _comment,
                                function: () => submitLeaveApplication(),
                                reliefOfficerData: _reliefOfficerData,
                              )
                            : padding(0)),
          ),
          bottomNavigationBar: bottomNavigation(context, "leave"),
        ),
      ),
    );
  }
}
