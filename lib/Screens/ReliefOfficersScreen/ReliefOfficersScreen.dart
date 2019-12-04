import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/PeopleWidget.dart';
import 'package:hr_flex/Data/LeaveData.dart';
import 'package:hr_flex/Screens/ReliefOfficersScreen/SearchBoxWidget.dart';

class ReliefOfficersScreen extends StatefulWidget {
  @override
  _ReliefOfficersScreenState createState() => _ReliefOfficersScreenState();
}

bool _isLoading;
List<dynamic> _reliefOfficers;
Timer _timer;
String _searchMessage;

class _ReliefOfficersScreenState extends State<ReliefOfficersScreen> {
  _getReliefOfficers(query) {
    _timer.cancel();
    setState(() {
      _isLoading = true;
    });

    _timer = Timer(Duration(milliseconds: 1000), () {
      LeaveData().getReliefOfficers(query).then((res) {
        _reliefOfficers = LeaveData.reliefOfficers;

        if (_reliefOfficers.length == 0) {
          setState(() {
            _searchMessage = "No relief officer matching your search criteria";
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    });
  }

  _updateReliefOfficerData(rod) {
    LeaveData().updateReliefOfficerData(rod);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _reliefOfficers = [];
    _timer = Timer(Duration(milliseconds: 1), () {});
    _searchMessage = "Search with name of your relief officer";
    LeaveData().getReliefOfficers("").then((res) {
      _reliefOfficers = LeaveData.reliefOfficers;

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: DeviceConfig.screenHeight,
        width: DeviceConfig.screenWidth,
        padding: EdgeInsets.only(top: sh(60)),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sh(30.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: sf(18),
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  padding(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(sh(15.0)),
                        child: Text(
                          "Add Relief Officer",
                          style: TextStyle(
                            fontSize: sf(18.0),
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(sh(2.0)),
                          child: Text(
                            "${_reliefOfficers.length} Results found",
                            style: TextStyle(
                              fontSize: sf(12.0),
                              color: AppColors.lightPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SearchBoxWidget(
                    onChange: (v) => _getReliefOfficers(v),
                  ),
                ],
              ),
            ),
            padding(20.0),
            Divider(
              color: AppColors.greyColor.withOpacity(0.5),
            ),
            _isLoading
                ? Container(
                    padding: EdgeInsets.all(sh(30)),
                    width: DeviceConfig.screenWidth,
                    color: AppColors.whiteColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: sw(30.0),
                            width: sw(30.0),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  AppColors.lightPrimaryColor),
                              strokeWidth: sw(5.0),
                            ),
                          ),
                          padding(30.0),
                          Padding(
                            padding: EdgeInsets.all(sw(30.0)),
                            child: Text(
                              "Getting relief officers...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.lightPrimaryColor,
                                  fontSize: sf(12.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : _reliefOfficers.length == 0
                    ? Container(
                        width: DeviceConfig.screenWidth,
                        padding: EdgeInsets.symmetric(
                            horizontal: sh(100.0), vertical: sh(20)),
                        child: Text(
                          _searchMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.lightPrimaryColor,
                            fontSize: sf(16.0),
                          ),
                        ),
                      )
                    : Flexible(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: sh(20.0)),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: _reliefOfficers
                                      .map<Widget>((reliefOfficer) => InkWell(
                                            child: PeopleWidget(
                                              name: reliefOfficer["name"],
                                              description:
                                                  reliefOfficer["designation"],
                                              image: imageBytes(
                                                reliefOfficer["image"],
                                                sh(60.0),
                                                sh(60.0),
                                                false,
                                              ),
                                              suffixWidget: SvgPicture.asset(
                                                "assets/images/chevronright.svg",
                                                color: AppColors.lightGreyColor,
                                              ),
                                              hasDivider: reliefOfficer ==
                                                      _reliefOfficers[
                                                          _reliefOfficers
                                                                  .length -
                                                              1]
                                                  ? false
                                                  : true,
                                            ),
                                            onTap: () =>
                                                _updateReliefOfficerData(
                                                    reliefOfficer),
                                          ))
                                      .toList(),
                                ),
                                padding(20.0),
                              ],
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
