// This is the walkthrough screen stateful class
import 'package:flutter/material.dart';
import 'package:hr_flex/Screens/WalkThroughScreen/Slides.dart';
import 'package:hr_flex/Common/functions.dart';

class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  //These are the walkthrough screens variable declarations
  List<String> _slideBackgroundImages;
  List<String> _slideTitleList;
  List<String> _slideTextList;

  // This instantiates the walkthrough screen properties
  @override
  void initState() {
    super.initState();

    _slideBackgroundImages = [
      'assets/images/slide3.png',
      'assets/images/slide3.png',
      'assets/images/slide3.png',
    ]; // The list length must be equal to the number of slides
    _slideTitleList = [
      'Salaries & Payslips',
      'Manage your Vacation',
      'Company Activities',
    ]; // The list length must be equal to the number of slides
    _slideTextList = [
      'View, and request your Payslips, Remiitance',
      'Schedule your Vacation, view your Team’s upcoming calendar',
      'See New Hires, Birthdays, and other Company information',
    ]; // The list length must be equal to the number of slides
  }

  // This disposes the widget and all properties when the user navigates from this screen
  @override
  void dispose() {
    super.dispose();
  }

  //This pushes to the login screen
  _goToLoginScreen() {
    pushScreen(context, '/LoginScreen');
  }

  @override
  // This is the walkthrough screen UI
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Slides(
            slideBackgroundImages: _slideBackgroundImages,
            slideTitleList: _slideTitleList,
            slideTextList: _slideTextList,
            goToLoginScreen: _goToLoginScreen),
      ),
    );
  }
}
