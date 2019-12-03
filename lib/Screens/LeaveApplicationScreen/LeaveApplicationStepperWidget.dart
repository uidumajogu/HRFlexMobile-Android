import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class LeaveApplicationStepperWidget extends StatelessWidget {
  final int index;
  final int stepperLength;

  LeaveApplicationStepperWidget({
    @required this.index,
    @required this.stepperLength,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> stepper = [];

    for (var i = 0; i < stepperLength; i++) {
      stepper.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(3.0)),
        child: Container(
            height: sh(10.0),
            width: sh(10.0),
            decoration: BoxDecoration(
                color: i <= index
                    ? AppColors.lightGreyColor
                    : AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.lightGreyColor)),
            child: null),
      ));
    }

    return Row(
      children: stepper,
    );
  }
}
