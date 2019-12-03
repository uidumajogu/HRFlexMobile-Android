import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceScale.dart';
import 'package:hr_flex/Data/EmployeeData.dart';
import 'package:hr_flex/Data/PayrollData.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//This pops current screen and pushes a new screen
setAsRootScreen(BuildContext context, String route) {
  if (route != null) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(route);
  }
}

//This pushes a new screen on top of the current one
pushScreen(BuildContext context, String route) {
  if (route != null) {
    Navigator.of(context).pushNamed(route);
  }
}

pushScreenWithData(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

//This determines wether the screen size is tablet or mobile
bigScreen(BuildContext context) {
  if (MediaQuery.of(context).size.width > 800) {
    return true;
  }
  return false;
}

setOrientation(String orientation) {
  //set the screen orientation
  if (orientation == "reset") {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  if (orientation == "landscape") {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  if (orientation == "portrait") {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

//This displays confirmation alert alert
confirmationAlert(BuildContext context, String message,
    Function(bool confirm) confirmAction) {
  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: AppColors.dangerColor, fontSize: sf(14.0)),
    ),
    onPressed: () {
      confirmAction(false);
      Navigator.of(context).pop();
    },
  );

  Widget confirmButton = RaisedButton(
    padding: EdgeInsets.symmetric(horizontal: sh(30)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sh(30.0)),
        side: BorderSide(
          color: AppColors.brownColor,
        )),
    color: AppColors.lightPrimaryColor,
    child: Text(
      "Confirm",
      style: TextStyle(color: AppColors.whiteColor, fontSize: sf(16.0)),
    ),
    onPressed: () {
      confirmAction(true);
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(sw(20.0)))),
    title: Text(
      "Confirm",
      style: TextStyle(
          color: AppColors.lightPrimaryColor,
          fontSize: sf(24.0),
          fontWeight: FontWeight.w500),
    ),
    content: Text(message,
        style: TextStyle(
            color: AppColors.greyColor,
            fontSize: sf(14.0),
            fontWeight: FontWeight.w500)),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//This displays success alert alert
successAlert(BuildContext context, String message) {
  Widget closeButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(color: AppColors.greenColor, fontSize: sf(16.0)),
    ),
    onPressed: () => Navigator.of(context).pop(),
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(sw(20.0)))),
    title: Text(
      "Success",
      style: TextStyle(
          color: AppColors.greenColor,
          fontSize: sf(24.0),
          fontWeight: FontWeight.w500),
    ),
    content: Text(message,
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: sf(14.0),
            fontWeight: FontWeight.w500)),
    actions: [
      closeButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//This displays an error alert
errorAlert(BuildContext context, String error) {
  Widget closeButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(color: AppColors.dangerColor, fontSize: sf(16.0)),
    ),
    onPressed: () => Navigator.of(context).pop(),
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(sw(20.0)))),
    title: Text(
      "Error",
      style: TextStyle(
          color: AppColors.dangerColor,
          fontSize: sf(24.0),
          fontWeight: FontWeight.w500),
    ),
    content: Text(error,
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: sf(14.0),
            fontWeight: FontWeight.w500)),
    actions: [
      closeButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget imageBytes(String image, double width, double height, bool innerBorder) {
  final Uint8List _imageBytes = Base64Decoder().convert(image);
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      shape: BoxShape.circle,
      border: Border.all(
        color: AppColors.greyColor.withOpacity(0.4),
        width: sw(0.8),
        style: BorderStyle.solid,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(sw(2.0)),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
          border: innerBorder
              ? Border.all(
                  color: Colors.black,
                  width: sw(0.8),
                  style: BorderStyle.solid,
                )
              : null,
          image: DecorationImage(
            image: Image.memory(
              _imageBytes,
            ).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

void modalBottomSheetMenu(BuildContext context, Widget widget) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: widget,
          ),
        );
      });
}

String formatNumber(number) {
  final formatter =
      number == 0 ? NumberFormat("0.00") : NumberFormat("#,###.00");
  return formatter.format(number);
}

openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

openEmail(String email) async {
  if (await canLaunch("mailto:$email")) {
    await launch("mailto:$email");
  } else {
    throw 'Could not open $email';
  }
}

Widget simplePopup(List<String> text, int count, BuildContext context,
    Function(int value) onPressed) {
  List<PopupMenuEntry<int>> popupMenuItems = [];
  for (int i = 0; i < count; i++) {
    popupMenuItems.add(PopupMenuItem(
      value: i,
      child: Text(
        "${text[i]}",
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: sf(16.0),
        ),
      ),
    ));
  }
  return PopupMenuButton<int>(
    icon: Icon(
      Icons.more_vert,
      color: AppColors.whiteColor,
      size: sh(35.0),
    ),
    color: AppColors.accentColor,
    padding: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(sh(5.0)),
    ),
    itemBuilder: (context) => popupMenuItems,
    onSelected: (v) => onPressed(v),
  );
}

logout(BuildContext context) {
  EmployeeData().resetEmployeeProfile();
  PayrollData().resetPayrollPeriod();
  setAsRootScreen(context, "/LoginScreen");
}

//This returns a scaled font size
sf(double val) {
  return DeviceScale.scale.setSp(val);
}

//This returns a padding
padding(double size) {
  return Padding(
    padding: EdgeInsets.only(top: DeviceScale.scale.setHeight(size)),
  );
}

//This returns the logo
logoText(double size) {
  return Image.asset(
    "assets/images/logoText.png",
    height: DeviceScale.scale.setHeight(size),
  );
}

//This returns the logo text
logo(double size) {
  return Image.asset(
    "assets/images/logo.png",
    height: DeviceScale.scale.setHeight(size),
  );
}

//This returns a formatted image (png, jpg, jpeg...)
image(String imgUrl, double size, Color color) {
  return Image.asset(
    imgUrl,
    height: DeviceScale.scale.setHeight(size),
    color: color,
  );
}

//This returns a scaled width
sw(double size) {
  return DeviceScale.scale.setWidth(size);
}

//This returns a scaled height
sh(double size) {
  return DeviceScale.scale.setHeight(size);
}
