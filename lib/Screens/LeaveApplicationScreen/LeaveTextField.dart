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
  final String enabled;
  final String initialValue;

  LeaveTextField({
    @required this.onSubmitted,
    @required this.textInputErrorMessage,
    @required this.onChange,
    @required this.labelText,
    @required this.textInputType,
    this.textFieldHeight,
    this.enabled,
    this.initialValue,
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
    _textFieldFocusNode = FocusNode();
    _textFieldController = widget.initialValue != null
        ? TextEditingController(text: widget.initialValue)
        : TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocusNode.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!widget.enabled) {
    //   widget.onChange(widget.initialValue);
    // }
    return TextField(
      maxLines: widget.textFieldHeight != null ? widget.textFieldHeight : 1,
      focusNode: _textFieldFocusNode,
      keyboardType: widget.textInputType,
      controller: _textFieldController,
      enabled: widget.enabled == "false" ? false : true,
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
          fontSize: sf(14.0),
        ),
        filled: true,
        fillColor: AppColors.backgroundColor,
        errorText:
            widget.enabled == "false" ? null : widget.textInputErrorMessage,
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
