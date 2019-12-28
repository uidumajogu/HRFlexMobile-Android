import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/PayrollData.dart';
import 'package:hr_flex/Screens/PayslipScreen/PayBar.dart';
import 'package:hr_flex/Screens/PayslipScreen/RatioBar.dart';

class MonthlyPayCard extends StatelessWidget {
  final Function(String type) onTap;

  MonthlyPayCard({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sh(10.0)),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(sh(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Last Payslip",
                      style: TextStyle(
                        fontSize: sf(12.0),
                        color: AppColors.brownColor,
                      ),
                    ),
                    Text(
                      PayrollData.currentPayslipDateData.isNotEmpty
                          ? PayrollData.currentPayslipDateData['title']
                          : "No payslip available",
                      style: TextStyle(
                        fontSize: sf(18.0),
                        color: AppColors.darkGreenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                padding(20.0),
                Text(
                  "Your pay breakdown",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: sf(12.0),
                    color: AppColors.greyColor,
                  ),
                ),
                padding(10.0),
                RatioBar(
                  first: PayrollData.payslip["deductionValue"] != null
                      ? PayrollData.payslip["deductionValue"]
                      : 1,
                  second: PayrollData.payslip["netValue"] != null
                      ? PayrollData.payslip["netValue"]
                      : 1,
                ),
                padding(20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Gross Pay",
                      style: TextStyle(
                        fontSize: sf(13.0),
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      PayrollData.payslip["gross"] != null
                          ? "${PayrollData.payslip["currency"]} ${formatNumber(PayrollData.payslip["gross"])}"
                          : "${formatNumber(0)}",
                      style: TextStyle(
                        fontSize: sf(20.0),
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                padding(20.0),
                PayBar(
                  description: "Deductions",
                  amount: PayrollData.payslip["deductionValue"] != null
                      ? "${PayrollData.payslip["currency"]} ${formatNumber(PayrollData.payslip["deductionValue"])}"
                      : "${formatNumber(0)}",
                  isAmountNegative: true,
                  isMonthlySlip: true,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: sw(20.0),
                  ),
                  child: Divider(
                    color: AppColors.greyColor.withOpacity(0.5),
                  ),
                ),
                PayBar(
                  description: "Net Pay",
                  amount: PayrollData.payslip["netValue"] != null
                      ? "${PayrollData.payslip["currency"]} ${formatNumber(PayrollData.payslip["netValue"])}"
                      : "${formatNumber(0)}",
                  isAmountNegative: false,
                  isMonthlySlip: true,
                ),
              ],
            ),
          ),
          if (PayrollData.payslip.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(sh(20.0)),
                    child: SvgPicture.asset(
                      "assets/images/more.svg",
                      color: AppColors.greyColor.withOpacity(0.5),
                    ),
                  ),
                  onTap: () => onTap("Payslip"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
