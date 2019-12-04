import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/ButtonWidget.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveTextField.dart';

class ChangeLeaveDaysForm extends StatefulWidget {
  final Map<dynamic, dynamic> leaveTaskData;
  final Function(bool changedLeaveDays, String newLeaveDays) submitLeaveDays;

  ChangeLeaveDaysForm({
    @required this.leaveTaskData,
    @required this.submitLeaveDays,
  });

  @override
  _ChangeLeaveDaysFormState createState() => _ChangeLeaveDaysFormState();
}

class _ChangeLeaveDaysFormState extends State<ChangeLeaveDaysForm> {
  String _newLeaveDays;
  String _newLeaveDaysErrorMessage;
  bool _changedLeaveDays;

  @override
  void initState() {
    super.initState();
    _newLeaveDays = widget.leaveTaskData["days"].toString();
    _newLeaveDaysErrorMessage = null;
    _changedLeaveDays = false;
  }

  _onChangeLeaveDays(v) {
    _newLeaveDays = v;
    setState(() {
      _newLeaveDaysErrorMessage = null;
    });
  }

  bool _enteredNewLeaveDays(v) {
    _newLeaveDays = v;

    if (_newLeaveDays == "") {
      return true;
    }

    if (int.parse(_newLeaveDays) > widget.leaveTaskData["days"]) {
      setState(() {
        _newLeaveDaysErrorMessage =
            "Number of days entered cannot be greater than the requested leave days";
      });
      return false;
    }

    return true;
  }

  _updateLeaveDays() {
    if (_enteredNewLeaveDays(_newLeaveDays)) {
      if (_newLeaveDays != "" &&
          _newLeaveDays != widget.leaveTaskData["days"]) {
        setState(() {
          _changedLeaveDays = true;
        });
      }
      widget.submitLeaveDays(_changedLeaveDays, _newLeaveDays);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
          padding: EdgeInsets.all(sw(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              padding(10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw(8.0)),
                child: LeaveTextField(
                  onSubmitted: (v) => _enteredNewLeaveDays(v),
                  textInputErrorMessage: _newLeaveDaysErrorMessage,
                  onChange: (v) => _onChangeLeaveDays(v),
                  labelText: 'Number of Days',
                  textInputType: TextInputType.number,
                ),
              ),
              padding(25.0),
              ButtonWidget(
                label: "Continue",
                suffixIcon: SvgPicture.asset(
                  "assets/images/chevronright.svg",
                  color: AppColors.accentColor,
                ),
                function: _updateLeaveDays,
              ),
            ],
          )),
    );
  }
}
