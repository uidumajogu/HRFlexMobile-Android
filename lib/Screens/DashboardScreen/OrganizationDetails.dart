import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/InfoWidget.dart';

Widget organizationDetails(
    Map<String, dynamic> clientDetails, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: sw(8.0), vertical: sw(20.0)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.all(
        Radius.circular(sw(10.0)),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(
        sw(15.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Organization Details",
                    style: TextStyle(
                      fontSize: sf(12.0),
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  Text(
                    clientDetails["name"],
                    style: TextStyle(
                        fontSize: sf(18.0),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.5))),
                child: imageBytes(
                  clientDetails["logo"],
                  sw(35.0),
                  sw(35.0),
                  false,
                ),
              )
            ],
          ),
          padding(10.0),
          InfoWidget(
            description: "Address",
            text: clientDetails["address"],
            hasDivider: true,
          ),
          InfoWidget(
            description: "Website",
            text: clientDetails["website"],
            image: InkWell(
              child: image("assets/images/externalLinkIcon.png", 25.0,
                  AppColors.brownColor),
              onTap: () {
                Navigator.pop(context);
                openURL(clientDetails["website"]);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
