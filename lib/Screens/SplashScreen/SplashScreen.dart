// This is the splash screen stateful class

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/DeviceScale.dart';
import 'package:hr_flex/Common/DeviceType.dart';
import 'package:hr_flex/Common/Functions.dart';

//These are the splash screens variable declarations
AnimationController _animationController;
Timer _ssd;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // This instantiates the splash screen properties

  @override
  void initState() {
    super.initState();
    //This animates the logo (rotates the logo)
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.repeat();

    _ssd = Timer(const Duration(seconds: 5), () {
      _animationController.stop();
      setAsRootScreen(context, "/WalkthroughScreen");
    });
  }

  // This disposes the widget and all properties when the user navigates from this screen
  @override
  void dispose() {
    super.dispose();
    _ssd.cancel();
  }

  @override

  // This is the main splash screen UI widget
  Widget build(BuildContext context) {
    //This checks and sets the screen type (phone or tablet)
    DeviceType().init(context);

    //This initializes the screen dimensions
    DeviceConfig().init(context);

    //This initializes the screen scale
    DeviceScale().init(context);

    //This returns the splash screen UI
    return Material(
      child: Scaffold(
        body: Container(
            width: DeviceConfig.screenWidth,
            height: DeviceConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/swoosh.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor.withOpacity(0.9),
                    BlendMode.hardLight),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    padding(DeviceConfig.screenHeight * 0.25),
                    AnimatedBuilder(
                      animation: _animationController,
                      child: Container(child: logo(50.0)),
                      builder: (BuildContext context, Widget _widget) {
                        return Transform.rotate(
                          angle: _animationController.value * 14,
                          child: _widget,
                        );
                      },
                    ),
                    padding(18.0),
                    logoText(25.0)
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: DeviceConfig.screenHeight * 0.1),
                  child: Text(
                    "HR MANAGEMENT",
                    style: TextStyle(
                      fontSize: sf(16.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                      letterSpacing: sf(10.0),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
