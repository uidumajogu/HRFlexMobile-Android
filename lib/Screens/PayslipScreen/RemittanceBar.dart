import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class RemittanceBar extends StatelessWidget {
  final String description;
  final String amount;
  final String text1;
  final String text2;
  final Function(String type) onTap;

  RemittanceBar({
    this.description,
    this.amount,
    this.text1,
    this.text2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (description != null)
                Text(
                  description,
                  style: TextStyle(
                    fontSize: sf(14.0),
                    color: AppColors.darkGreenColor,
                  ),
                ),
              if (amount != null) padding(5.0),
              if (amount != null)
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: sf(18.0),
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (text1 != null && text2 != null) padding(5.0),
              if (text1 != null)
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: sf(12.0),
                    color: AppColors.greyColor,
                  ),
                ),
              if (text2 != null)
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: sf(12.0),
                    color: AppColors.greyColor,
                  ),
                ),
            ],
          ),
          if (amount != "0.00" || amount == null)
            Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sh(20.0),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/more.svg",
                    color: AppColors.greyColor.withOpacity(0.5),
                  ),
                ),
                onTap: () => onTap(description),
              ),
            ),
        ],
      ),
    );
  }
}
