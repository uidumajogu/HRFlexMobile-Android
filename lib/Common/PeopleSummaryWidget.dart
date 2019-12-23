import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';

class PeopleSummaryWidget extends StatelessWidget {
  final List people;
  final String summaryType;
  final String title;
  final bool hasDivider;
  final Function function;

  PeopleSummaryWidget({
    @required this.people,
    @required this.summaryType,
    this.title,
    this.hasDivider,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    bool _hasDivider = false;
    if (hasDivider != null) {
      _hasDivider = hasDivider;
    }

    List<dynamic> _people = [];

    if (people.length > 3) {
      _people = _people.take(3);
    } else {
      _people = [...people, "final"];
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) padding(10.0),
          if (title != null)
            Text(
              title,
              style: TextStyle(
                color: AppColors.greyColor.withOpacity(0.8),
                fontSize: sf(12.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          padding(5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: Alignment.centerLeft,
                children: _people
                    .map<Widget>(
                      (person) => person == _people[_people.length - 1]
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: (_people.length - 1) * sh(25.0)),
                              child: Container(
                                width: sh(40.0),
                                height: sh(40.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.whiteColor,
                                    width: sh(8),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Text(
                                  people.length > _people.length
                                      ? "${_people.length - 1}+"
                                      : "${_people.length - 1}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ))
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: (_people.indexOf(person)) * sh(25.0)),
                              child: imageBytes(
                                person["image"],
                                sh(30.0),
                                sh(30.0),
                                false,
                              ),
                            ),
                    )
                    .toList(),
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(sh(15.0)))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: sh(10.0), horizontal: sh(35.0)),
                    child: Text(
                      "View",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sf(12.0),
                        color: AppColors.accentColor,
                      ),
                    ),
                  ),
                ),
                onTap: function,
              )
            ],
          ),
          if (_hasDivider)
            Padding(
              padding: EdgeInsets.only(top: sh(10.0)),
              child: Divider(
                color: AppColors.greyColor.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }
}
