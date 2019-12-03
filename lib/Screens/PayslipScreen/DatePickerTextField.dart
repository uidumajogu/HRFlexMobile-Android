import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DateUtil.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/PayrollData.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DatePickerTextField extends StatefulWidget {
  final String label;
  final Function resetError;

  DatePickerTextField({this.label, this.resetError});

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  TextEditingController _dateTextController;
  FocusNode _dateTextFocusNode;
  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;

  Future<Null> _selectDate(BuildContext context) async {
    if (widget.label == "From") {
      PayrollData.payslipReportMinRange = PayrollData.minPayslipDateData;
    }
    if (widget.label == "To") {
      PayrollData.payslipReportMaxRange = PayrollData.currentPayslipDateData;
    }
    setState(() {
      _selectedDate = DateTime(PayrollData.payslipReportMaxRange["year"],
          PayrollData.payslipReportMaxRange["month"]);
      _firstDate = DateTime(PayrollData.payslipReportMinRange["year"],
          PayrollData.payslipReportMinRange["month"]);
      _lastDate = DateTime(PayrollData.payslipReportMaxRange["year"],
          PayrollData.payslipReportMaxRange["month"]);
    });
    final DateTime picked = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null) {
      var _date = DateUtil().format("MMMM y", picked);
      if (widget.label == "From") {
        PayrollData().updatePayslipReportMinRange(_date);
      }
      if (widget.label == "To") {
        PayrollData().updatePayslipReportMaxRange(_date);
      }
      setState(() {
        _dateTextController.text = _date;
        _selectedDate = DateTime(PayrollData.payslipReportMaxRange["year"],
            PayrollData.payslipReportMaxRange["month"]);
        _firstDate = DateTime(PayrollData.payslipReportMinRange["year"],
            PayrollData.payslipReportMinRange["month"]);
        _lastDate = DateTime(PayrollData.payslipReportMaxRange["year"],
            PayrollData.payslipReportMaxRange["month"]);
      });
    }

    if (_dateTextController.text != "") {
      if (widget.label == "From") {
        PayrollData.reportRequestHasStartDate = true;
      }
      if (widget.label == "To") {
        PayrollData.reportRequestHasEndDate = true;
      }
    } else {
      if (widget.label == "From") {
        PayrollData.reportRequestHasStartDate = false;
      }
      if (widget.label == "To") {
        PayrollData.reportRequestHasEndDate = false;
      }
    }
  }

  _focusListener() {
    _unfocus();
    widget.resetError();
    _selectDate(context);
  }

  _unfocus() {
    _dateTextFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _dateTextController = TextEditingController();
    _dateTextFocusNode = FocusNode();
    _dateTextFocusNode.addListener(_focusListener);
    _selectedDate = DateTime(PayrollData.payslipReportMaxRange["year"],
        PayrollData.payslipReportMaxRange["month"]);
    _firstDate = DateTime(PayrollData.payslipReportMinRange["year"],
        PayrollData.payslipReportMinRange["month"]);
    _lastDate = DateTime(PayrollData.payslipReportMaxRange["year"],
        PayrollData.payslipReportMaxRange["month"]);
    PayrollData.reportRequestHasEndDate = false;
    PayrollData.reportRequestHasStartDate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _dateTextController.dispose();
    _dateTextFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyleActive = TextStyle(
      color: AppColors.darkGreenColor,
      fontWeight: FontWeight.bold,
    );

    TextStyle _textStyleInactive = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.normal,
    );
    return Container(
      child: TextField(
        controller: _dateTextController,
        focusNode: _dateTextFocusNode,
        keyboardType: TextInputType.text,
        style: _dateTextController.text == ""
            ? _textStyleInactive
            : _textStyleActive,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(sh(18.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sh(10.0)),
          ),
          labelText: widget.label,
          labelStyle: _dateTextController.text == ""
              ? _textStyleInactive
              : _textStyleActive,
          suffixIcon: Container(
            padding: EdgeInsets.all(sw(12.0)),
            child: SvgPicture.asset(
              "assets/images/calendar.svg",
              color: _dateTextController.text == ""
                  ? AppColors.greyColor.withOpacity(0.5)
                  : AppColors.darkGreenColor,
            ),
          ),
        ),
      ),
    );
  }
}
