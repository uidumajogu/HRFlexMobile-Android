import 'package:flutter/material.dart';

import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/PayrollData.dart';

import 'package:hr_flex/Screens/PayslipScreen/RemittanceBar.dart';

class RemittanceCard extends StatelessWidget {
  final Function(String type) onTap;

  RemittanceCard({this.onTap});
  @override
  Widget build(BuildContext context) {
    print(PayrollData.nhfRemittance["amount"]);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(sh(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Year to date",
                  style: TextStyle(
                    fontSize: sf(12.0),
                    color: AppColors.brownColor,
                  ),
                ),
                Text(
                  "Remittance",
                  style: TextStyle(
                    fontSize: sf(18.0),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            padding(20.0),
            RemittanceBar(
              description: "Employee Pension",
              amount: PayrollData.pensionRemittance["amount"] != null
                  ? "${PayrollData.pensionRemittance["amount"] != 0 ? PayrollData.payslip["currency"] : ""} ${formatNumber(PayrollData.pensionRemittance["amount"])}"
                  : "${formatNumber(0)}",
              text1: PayrollData.pensionRemittance["holder"],
              text2: PayrollData.pensionRemittance["number"],
              onTap: (t) => onTap(t),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: sh(5.0)),
              child: Divider(
                color: AppColors.greyColor.withOpacity(0.5),
              ),
            ),
            RemittanceBar(
              description: "Personal Income Tax",
              amount: PayrollData.taxRemittance["amount"] != null
                  ? "${PayrollData.pensionRemittance["amount"] != 0 ? PayrollData.payslip["currency"] : ""} ${formatNumber(PayrollData.taxRemittance["amount"])}"
                  : "${formatNumber(0)}",
              onTap: (t) => onTap(t),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: sh(5.0)),
              child: Divider(
                color: AppColors.greyColor.withOpacity(0.5),
              ),
            ),
            RemittanceBar(
              description: "NHF Contribution",
              amount: PayrollData.nhfRemittance["amount"] != null
                  ? "${PayrollData.pensionRemittance["amount"] != 0 ? PayrollData.payslip["currency"] : ""} ${formatNumber(PayrollData.nhfRemittance["amount"])}"
                  : "${formatNumber(0)}",
              text1: PayrollData.nhfRemittance["holder"],
              onTap: (t) => onTap(t),
            ),
            // padding(20.0),
          ],
        ),
      ),
    );
  }
}
