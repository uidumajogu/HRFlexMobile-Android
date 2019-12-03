import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/BottomNavigation.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/EmployeeData.dart';
import 'package:hr_flex/Data/PayrollData.dart';
import 'package:hr_flex/Screens/PayslipScreen/MonthlyPayCard.dart';
import 'package:hr_flex/Screens/PayslipScreen/RemittanceCard.dart';
import 'package:hr_flex/Screens/PayslipScreen/SelectDateRange.dart';
import 'package:hr_flex/Screens/PayslipScreen/SendPayrollInfoWidget.dart';

class PayslipScreen extends StatefulWidget {
  @override
  _PayslipScreenState createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  bool _isLoading;
  bool _isSending;
  String _infoType = "";
  List<String> _remittances = ["Tax", "Pension", "Nhf"];

  Future<bool> _getRemittances() async {
    for (var i = 0; i < _remittances.length; i++) {
      await PayrollData().getRemittances(_remittances[i]);
    }

    setState(() {
      _isLoading = false;
    });

    return true;
  }

  _sendPayrollInfo(String type, String querry) {
    _infoType = type;
    Navigator.pop(context);
    String _type = "";
    setState(() {
      _isSending = true;
    });

    if (type == "Payslip") {
      _type = "Payslip";
    }

    if (type == "Employee Pension") {
      _type = "Pension";
    }

    if (type == "Personal Income Tax") {
      _type = "Tax";
    }

    if (type == "NHF Contribution") {
      _type = "Nhf";
    }

    PayrollData().sendPayrollInfo(_type, querry).then((res) {
      setState(() {
        _isSending = false;
      });

      if (res) {
        successAlert(context,
            "The request for your $type report has been submitted successfuly!");
      } else {
        errorAlert(context,
            "Sorry, an error has occurred. Failed to submit the request for your $type report. Please try again");
      }
    });
  }

  _openDatePickerModal(String type) {
    Navigator.pop(context);
    modalBottomSheetMenu(
      context,
      SelectDateRange(
        type: type,
        sendReport: (t, q) => _sendPayrollInfo(t, q),
      ),
    );
  }

  _sendPayslip(String type) {
    modalBottomSheetMenu(
      context,
      sendPayrollInfoWidget(
        context,
        type,
        (t, q) => _sendPayrollInfo(t, q),
        () => _openDatePickerModal(type),
      ),
    );
  }

  // This instantiates the Payslip screen properties
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isSending = false;
    var _pi = 0;
    PayrollData().resetRangeValues();
    if (PayrollData.payrollPeriod == null) {
      PayrollData().getParoll().then((res) {
        if (PayrollData.currentPayslipDateData != null) {
          PayrollData()
              .getPayslip(
                  PayrollData.currentPayslipDateData["month"].toString(),
                  PayrollData.currentPayslipDateData["year"].toString())
              .then((res) {
            PayrollData().getRemittances(_remittances[_pi]).then((res) {
              _getRemittances();
            });
          });
        } else {
          _getRemittances();
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: sw(8.0)),
                        child: Text(
                          "Payslips",
                          style: TextStyle(
                            fontSize: sf(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: sw(8.0)),
                        height: sh(22.0),
                        width: sh(22.0),
                        child: SvgPicture.asset(
                          "assets/images/payslip.svg",
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Requests right from your phone",
                    style: TextStyle(
                      fontSize: sf(10.0),
                      color: AppColors.lightColor.withOpacity(0.9),
                    ),
                  )
                ],
              ),
              EmployeeData.employeeProfile["image"] != null
                  ? imageBytes(
                      EmployeeData.employeeProfile["image"],
                      sh(30.0),
                      sh(30.0),
                      false,
                    )
                  : Padding(
                      padding: EdgeInsets.all(sh(8.0)),
                    ),
            ],
          ),
          centerTitle: false,
        ),
        body: Stack(
          children: <Widget>[
            _isLoading
                ? Container(
                    height: DeviceConfig.screenHeight,
                    width: DeviceConfig.screenWidth,
                    color: AppColors.lightColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: sh(50.0),
                          width: sh(50.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.accentColor),
                            strokeWidth: sh(5.0),
                          ),
                        ),
                        padding(30.0),
                        Padding(
                          padding: EdgeInsets.all(sh(20.0)),
                          child: Text(
                            "Getting your payslip information...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: sf(14.0),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(sh(10.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            padding(10.0),
                            MonthlyPayCard(
                              onTap: (ps) => _sendPayslip(ps),
                            ),
                            padding(10.0),
                            RemittanceCard(
                              onTap: (ps) => _sendPayslip(ps),
                            ),
                            padding(10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
            if (_isSending)
              Container(
                height: DeviceConfig.screenHeight,
                width: DeviceConfig.screenWidth,
                color: AppColors.lightColor.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: sh(50.0),
                      width: sh(50.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.accentColor),
                        strokeWidth: sh(5.0),
                      ),
                    ),
                    padding(50.0),
                    Padding(
                      padding: EdgeInsets.all(sh(20.0)),
                      child: Text(
                        "Sending your $_infoType report to your registered email...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: sf(14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
        bottomNavigationBar:
            _isLoading ? null : bottomNavigation(context, "payslip"),
      ),
    );
  }
}
