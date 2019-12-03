// This is the slides stateless class
import 'package:flutter/material.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/DeviceType.dart';

class Slides extends StatelessWidget {
  //These are the slide variable declarations
  final List<String> slideBackgroundImages;
  final List<String> slideTitleList;
  final List<String> slideTextList;
  final Function goToLoginScreen;

  Slides(
      {@required this.slideBackgroundImages,
      @required this.slideTitleList,
      @required this.slideTextList,
      @required this.goToLoginScreen});

  @override
  Widget build(BuildContext context) {
    final _numberOsflides = slideTitleList.length;
    List<Widget> _slidePaginationBars = new List(_numberOsflides);
    List<Widget> _slideScreens = new List(_numberOsflides);

    for (int i = 0; i < _numberOsflides; i++) {
      //This generates the slide pagination bars
      _slidePaginationBars = new List(_numberOsflides);
      for (int j = 0; j < _numberOsflides; j++) {
        _slidePaginationBars[j] = Padding(
          padding: EdgeInsets.all(sh(5.0)),
          child: image('assets/images/line.png', sh(3),
              j == i ? AppColors.accentColor : AppColors.greyColor),
        );
      }

      //This generates the slides
      _slideScreens[i] = Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(slideBackgroundImages[i]),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  BlendMode.hardLight)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceConfig.screenWidth * 0.1,
            vertical: DeviceConfig.screenHeight * 0.1,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceType.isPhone
                    ? 0.0
                    : DeviceConfig.orientation == Orientation.portrait
                        ? DeviceConfig.screenWidth * 0.1
                        : DeviceConfig.screenWidth * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                logoText(25.0),
                Column(
                  children: <Widget>[
                    Text(
                      slideTitleList[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: sf(28.0),
                          fontWeight: FontWeight.w800,
                          color: AppColors.whiteColor),
                    ),
                    padding(20.0),
                    Text(
                      slideTextList[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: sf(18.0),
                          fontWeight: FontWeight.w300,
                          color: AppColors.whiteColor),
                    ),
                    padding(40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _slidePaginationBars,
                    ),
                    padding(60.0),
                    image('assets/images/swipeIcon.png', sh(25),
                        AppColors.whiteColor),
                    padding(10.0),
                    Text(
                      'Swipe for More',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: sf(11.0),
                          fontWeight: FontWeight.w300,
                          color: AppColors.whiteColor.withOpacity(0.7)),
                    ),
                    padding(50.0),
                    i == (_numberOsflides - 1)
                        ? RaisedButton(
                            padding: EdgeInsets.all(sh(20)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(sh(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: sf(18.0),
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: sf(18.0),
                                  color: AppColors.primaryColor,
                                )
                              ],
                            ),
                            onPressed: goToLoginScreen)
                        : InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: sw(50.0),
                                vertical: sh(20.0),
                              ),
                              child: Text(
                                'Skip',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: sf(22.0),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                            onTap: goToLoginScreen,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    //This returns the slide widget
    return PageView(children: _slideScreens);
  }
}
