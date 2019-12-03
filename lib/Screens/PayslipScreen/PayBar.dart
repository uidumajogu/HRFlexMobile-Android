import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class PayBar extends StatelessWidget {
  final String description;
  final String amount;
  final bool isAmountNegative;
  final bool isMonthlySlip;
  final double percentage;

  PayBar({
    this.description,
    this.amount,
    this.isAmountNegative,
    this.percentage,
    @required this.isMonthlySlip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Row(
            children: <Widget>[
              Container(
                height: sh(40.0),
                width: sw(5.0),
                margin: EdgeInsets.only(
                  right: sw(10.0),
                ),
                decoration: BoxDecoration(
                  color: isAmountNegative
                      ? AppColors.brownColor
                      : AppColors.darkGreenColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: sf(12.0),
                      color: AppColors.greyColor,
                    ),
                  ),
                  Text(
                    isAmountNegative ? "($amount)" : amount,
                    style: TextStyle(
                        fontSize: isAmountNegative ? sf(14.0) : sf(16.0),
                        color: AppColors.primaryColor,
                        fontWeight: isAmountNegative
                            ? FontWeight.w400
                            : FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
