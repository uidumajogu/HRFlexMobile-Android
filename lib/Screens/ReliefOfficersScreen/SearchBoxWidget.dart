import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class SearchBoxWidget extends StatelessWidget {
  final Function(String searchValue) onChange;

  SearchBoxWidget({
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: sh(18.0), vertical: sh(18.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGreyColor),
          borderRadius: BorderRadius.circular(sh(10.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGreyColor),
          borderRadius: BorderRadius.circular(sh(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentColor),
          borderRadius: BorderRadius.circular(sh(10.0)),
        ),
        hintText: "Search...",
        hintStyle: TextStyle(color: AppColors.lightGreyColor),
        filled: true,
        fillColor: AppColors.backgroundColor,
        suffixIcon: Padding(
          padding: EdgeInsets.all(sh(12.0)),
          child: SvgPicture.asset(
            "assets/images/searchicon.svg",
            color: AppColors.accentColor,
          ),
        ),
      ),
      onChanged: (v) {
        onChange(v);
      },
    );
  }
}
