// This is the slides stateless class
import 'package:flutter/material.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/DeviceType.dart';

class Slides extends StatefulWidget {
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
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  PageController _pageController;
  int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final _numberOsflides = widget.slideTitleList.length;
    List<Widget> _slidePaginationBars = new List(_numberOsflides);
    List<Widget> _slideScreens = new List(_numberOsflides);

    for (int i = 0; i < _numberOsflides; i++) {
      //This generates the slide pagination bars
      _slidePaginationBars = new List(_numberOsflides);
      for (int j = 0; j < _numberOsflides; j++) {
        _slidePaginationBars[j] = Padding(
          padding: EdgeInsets.all(sh(3.0)),
          child: Container(
            height: 2.8,
            width: sw(50),
            color: j == i ? AppColors.accentColor2 : AppColors.greyColor2,
          ),
        );
      }

      //This generates the slides
      _slideScreens[i] = Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.slideBackgroundImages[i]),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  BlendMode.hardLight)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: DeviceConfig.screenWidth * 0.07,
            right: DeviceConfig.screenWidth * 0.07,
            top: DeviceConfig.screenHeight * 0.1,
            bottom: DeviceConfig.screenHeight * 0.05,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceType.isPhone
                    ? 0.0
                    : DeviceConfig.orientation == Orientation.portrait
                        ? DeviceConfig.screenWidth * 0.1
                        : DeviceConfig.screenWidth * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                logoText(25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: sw(230.0),
                      child: Text(
                        widget.slideTitleList[i],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: sf(27.0),
                            fontWeight: FontWeight.w800,
                            color: AppColors.lightLemonColor),
                      ),
                    ),
                    padding(10.0),
                    Text(
                      widget.slideTextList[i],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: sf(18.0),
                          fontWeight: FontWeight.w300,
                          color: AppColors.whiteColor.withOpacity(0.8)),
                    ),
                    padding(30.0),
                    RaisedButton(
                      color: AppColors.darkPrimaryColor,
                      padding: EdgeInsets.all(sh(20)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sh(10.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: DeviceConfig.screenWidth * 0.7,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: DeviceConfig.screenWidth * 0.32,
                              ),
                              child: Text(
                                'Login',
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: sf(18.0),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Icon(
                              Icons.chevron_right,
                              size: sf(18.0),
                              color: AppColors.accentColor,
                            ),
                          )
                        ],
                      ),
                      onPressed: widget.goToLoginScreen,
                    ),
                    padding(50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _slidePaginationBars,
                        ),
                        if (i < (_numberOsflides - 1))
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(
                                sw(10.0),
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
                            onTap: () => {
                              _pageController.animateToPage(
                                _pageIndex + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              )
                            },
                          ),
                      ],
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
    return PageView(
      controller: _pageController,
      children: _slideScreens,
      onPageChanged: (i) {
        _pageIndex = i;
      },
    );
  }
}
