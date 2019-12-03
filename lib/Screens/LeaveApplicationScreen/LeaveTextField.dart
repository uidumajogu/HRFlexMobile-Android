import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class LeaveTextField extends StatefulWidget {
  final Function(String submit) onSubmitted;
  final String textInputErrorMessage;
  final Function(String change) onChange;
  final String labelText;
  final TextInputType textInputType;
  final int textFieldHeight;

  LeaveTextField({
    @required this.onSubmitted,
    @required this.textInputErrorMessage,
    @required this.onChange,
    @required this.labelText,
    @required this.textInputType,
    this.textFieldHeight,
  });

  @override
  _LeaveTextFieldState createState() => _LeaveTextFieldState();
}

class _LeaveTextFieldState extends State<LeaveTextField> {
  FocusNode _textFieldFocusNode;
  TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = new FocusNode();
    _textFieldController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocusNode.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.textFieldHeight != null ? widget.textFieldHeight : 1,
      focusNode: _textFieldFocusNode,
      keyboardType: widget.textInputType,
      controller: _textFieldController,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: sh(18.0), vertical: sh(18.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightColor),
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
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.lightGreyColor,
          fontWeight: FontWeight.normal,
          fontSize: sf(20.0),
        ),
        filled: true,
        fillColor: AppColors.backgroundColor,
        errorText: widget.textInputErrorMessage,
        errorMaxLines: 4,
      ),
      onChanged: (v) {
        widget.onChange(v);
      },
      onSubmitted: (v) {
        widget.onSubmitted(v);
      },
    );
  }
}
