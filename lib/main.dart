import 'package:flutter/material.dart';
import 'package:hr_flex/Screens/BirthDayScreen/BirthdayScreen.dart';
import 'package:hr_flex/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:hr_flex/Screens/LeaveApplicationScreen/LeaveApplicationScreen.dart';
import 'package:hr_flex/Screens/LeaveRequestTaskScreen/LeaveRequestTaskDetailsCardScreen.dart';
import 'package:hr_flex/Screens/LeaveRequestTaskScreen/LeaveRequestTaskScreen.dart';
import 'package:hr_flex/Screens/LeaveScreen/LeaveScreen.dart';
import 'package:hr_flex/Screens/LoginScreen/LoginScreen.dart';
import 'package:hr_flex/Screens/NewHireScreen/NewHireScreen.dart';
import 'package:hr_flex/Screens/PayslipScreen/PayslipScreen.dart';
import 'package:hr_flex/Screens/ReliefOfficersScreen/ReliefOfficersScreen.dart';
import 'package:hr_flex/Screens/SplashScreen/SplashScreen.dart';
import 'package:hr_flex/Screens/TeamLeaveCalendarScreen/TeamLeaveCalendarScreen.dart';
import 'package:hr_flex/Screens/WalkThroughScreen/WalkThroughScreen.dart';
import 'package:hr_flex/Common/ColorTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRFlex',
      theme: ThemeData(
        // Sets the color theme of the application.
        primarySwatch: AppColors.primarySwatchColor,
        accentColor: AppColors.accentColor,
        canvasColor: AppColors.canvasColor,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: SplashScreen(),
      //The is the application screen routes
      routes: <String, WidgetBuilder>{
        '/SplashScreen': (BuildContext context) => SplashScreen(),
        '/WalkthroughScreen': (BuildContext context) => WalkthroughScreen(),
        '/LoginScreen': (BuildContext context) => LoginScreen(),
        '/DashboardScreen': (BuildContext context) => DashboardScreen(),
        '/LeaveScreen': (BuildContext context) => LeaveScreen(),
        '/BirthdayScreen': (BuildContext context) => BirthdayScreen(
              birthdaysTodayList: [],
            ),
        '/NewHireScreen': (BuildContext context) => NewHireScreen(
              newHireList: [],
            ),
        '/PayslipScreen': (BuildContext context) => PayslipScreen(),
        '/TeamLeaveCalendarScreen': (BuildContext context) =>
            TeamLeaveCalendarScreen(),
        '/LeaveApplicationScreen': (BuildContext context) =>
            LeaveApplicationScreen(
              leaveTypeData: {},
            ),
        '/ReliefOfficersScreen': (BuildContext context) =>
            ReliefOfficersScreen(),
        '/LeaveRequestTaskScreen': (BuildContext context) =>
            LeaveRequestTaskScreen(),
        '/LeaveRequestTaskDetailsCardScreen': (BuildContext context) =>
            LeaveRequestTaskDetailsCardScreen(
              leaveTaskData: {},
            ),
      },
    );
  }
}
