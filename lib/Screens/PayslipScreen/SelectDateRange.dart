import 'package:flutter/material.dart';

import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/PayrollData.dart';
import 'package:hr_flex/Screens/PayslipScreen/DatePickerTextField.dart';

class SelectDateRange extends StatefulWidget {
  final String type;
  final Function(String type, String querry) sendReport;

  SelectDateRange({this.type, this.sendReport});

  @override
  _SelectDateRangeState createState() => _SelectDateRangeState();
}

class _SelectDateRangeState extends State<SelectDateRange> {
  bool _noStartDate;
  bool _noEndDate;

  _submitRequest() {
    if (!PayrollData.reportRequestHasStartDate) {
      setState(() {
        _noStartDate = true;
      });
      return;
    }

    if (!PayrollData.reportRequestHasEndDate) {
      setState(() {
        _noEndDate = true;
      });
      return;
    }

    widget.sendReport(widget.type,
        "?periodFrom=${PayrollData.payslipReportMinRange["id"]}&periodTo=${PayrollData.payslipReportMaxRange["id"]}");
  }

  _resetError() {
    setState(() {
      _noStartDate = false;
      _noEndDate = false;
      return;
    });
  }

  @override
  void initState() {
    super.initState();
    _noStartDate = false;
    _noEndDate = false;
    PayrollData().resetRangeValues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            sh(20.0),
          ),
          topRight: Radius.circular(
            sh(20.0),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          padding(30.0),
          Text(
            "Send ${widget.type}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: sf(14.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          padding(1.0),
          Text(
            "Select the period",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: sf(14.0),
            ),
          ),
          padding(20.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sf(30.0),
            ),
            child: DatePickerTextField(
              label: "From",
              resetError: _resetError,
            ),
          ),
          if (_noStartDate)
            Text(
              "The report start date is required...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.dangerColor,
                fontSize: sf(14.0),
              ),
            ),
          padding(20.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sw(30.0),
            ),
            child: DatePickerTextField(
              label: "To",
              resetError: _resetError,
            ),
          ),
          if (_noEndDate)
            Text(
              "The report end date is required...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.dangerColor,
                fontSize: sf(14.0),
              ),
            ),
          padding(10.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sw(30.0),
            ),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sh(10.0)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: sh(15.0),
              ),
              color: AppColors.accentColor,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: AppColors.darkGreenColor,
                  fontSize: sf(22.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _submitRequest,
            ),
          ),
          padding(30.0),
        ],
      ),
    );
  }
}
