import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class LeaveDatePickerTextField extends StatefulWidget {
  final Function(String selectedStartDate) startDate;
  final String dateErrorText;

  LeaveDatePickerTextField({
    @required this.startDate,
    @required this.dateErrorText,
  });

  @override
  _LeaveDatePickerTextFieldState createState() =>
      _LeaveDatePickerTextFieldState();
}

class _LeaveDatePickerTextFieldState extends State<LeaveDatePickerTextField> {
  TextEditingController dateTextController;
  FocusNode dateFocusNode;
  String _dateErrorText;
  final dateFormat = DateFormat("yyyy-MM-dd");
  String selectedLeaveDate;

  _textListener() {
    final _dText = dateTextController.text == ''
        ? dateTextController.text
        : dateTextController.text.toUpperCase();
    dateTextController.value = dateTextController.value.copyWith(
      text: _dText,
      selection:
          TextSelection(baseOffset: _dText.length, extentOffset: _dText.length),
      composing: TextRange.empty,
    );
    selectedLeaveDate = _dText;
  }

  @override
  void initState() {
    super.initState();
    selectedLeaveDate = "";
    dateTextController = TextEditingController();
    dateFocusNode = new FocusNode();
    dateTextController.addListener(_textListener);
  }

  @override
  void dispose() {
    super.dispose();
    dateFocusNode.dispose();
    dateTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dateErrorText = widget.dateErrorText;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(sh(10.0))),
      child: DateTimeField(
        controller: dateTextController,
        focusNode: dateFocusNode,
        readOnly: true,
        format: dateFormat,
        resetIcon: null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(sh(18.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.lightColor,
            ),
            borderRadius: BorderRadius.circular(sh(10.0)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightColor),
            borderRadius: BorderRadius.circular(sh(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(sh(10.0)),
          ),
          labelText: "Start Date",
          labelStyle: TextStyle(
            color: AppColors.lightGreyColor,
            fontWeight: FontWeight.normal,
            fontSize: sf(20.0),
          ),
          filled: true,
          fillColor: AppColors.backgroundColor,
          errorText: selectedLeaveDate == "" ? _dateErrorText : null,
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(sh(10.0)),
                bottomRight: Radius.circular(sh(10.0)),
              ),
            ),
            padding: EdgeInsets.all(sh(15.0)),
            child: SvgPicture.asset(
              "assets/images/calendar.svg",
              color: AppColors.accentColor,
            ),
          ),
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime.now().add(Duration(days: 1)),
            initialDate: currentValue ?? DateTime.now().add(Duration(days: 1)),
            lastDate: DateTime(DateTime.now().year + 1),
          );
        },
        onChanged: (value) {
          widget.startDate(selectedLeaveDate);
        },
      ),
    );
  }
}
