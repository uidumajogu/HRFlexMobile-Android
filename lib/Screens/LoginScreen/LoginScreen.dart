// This is the login screen stateful class

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/Functions.dart';
import 'package:hr_flex/Data/ClientData.dart';
import 'package:hr_flex/Common/ColorTheme.dart';
import 'package:hr_flex/Common/DeviceConfig.dart';
import 'package:hr_flex/Common/ApiUtil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameTextController;
  TextEditingController _passwordTextController;
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  String _usernameErrorMessage;
  String _passwordErrorMessage;
  bool _loginIn;
  bool _loginSuccess;
  ApiUtil _apiUtil;
  final _loginURL = APIpathUtil.baseURL + APIpathUtil.loginPATH;
  bool _rememberMe;

  // This instantiates the login screen properties
  @override
  void initState() {
    super.initState();
    _rememberMe = false;
    _usernameTextController = new TextEditingController();
    _passwordTextController = new TextEditingController();
    _usernameFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
    _usernameErrorMessage = null;
    _passwordErrorMessage = null;
    _loginIn = false;
    _loginSuccess = false;
    _apiUtil = new ApiUtil();
  }

  // This disposes the widget and all properties when the user navigates from this screen
  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  //This navigates user to the dashboard screen
  _goToDashboardScreen() {
    new Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _loginSuccess = true;
        setAsRootScreen(context, '/DashboardScreen');
      });
    });
  }

  _resetState() {
    setState(() {
      _loginIn = false;
      _usernameTextController.text = "";
      _passwordTextController.text = "";
    });
  }

  //function to login user
  void _loginUser(String username, String password) {
    _apiUtil.post(_loginURL, headers: APIpathUtil.loginHEADERS, body: {
      "username": "OT1702199",
      "password": "Quetz@l2019",
    }).then((dynamic res) {
      if (res["response"] == "Error") {
        errorAlert(context, res["reason"]);
        _loginSuccess = false;
        _resetState();
      } else {
        APIpathUtil.accessToken["accessToken"] = res["details"]["accessToken"];
        APIpathUtil.accessToken["expirationDate"] =
            res["details"]["expirationDate"];

        ClientData().getClientProfile().then((resp) {
          if (resp == false) {
            errorAlert(context, "Authorization failed. Please try again..");
            _loginSuccess = false;
            _resetState();
          } else {
            _goToDashboardScreen();
          }
        });
      }
    });
  }

  //function to check login inputs
  _checkInputs() {
    String _username = _usernameTextController.text;
    String _password = _passwordTextController.text;
    if (_username == "") {
      _usernameErrorMessage = "A username is required";
      _loginIn = false;
    } else {
      if (_password == "") {
        _passwordErrorMessage = "A Password is required";
        _loginIn = false;
      } else {
        _loginUser(_username, _password);
        // print(sl);
      }
    }
  }

  @override
  // This is the main login screen UI widget
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: DeviceConfig.screenHeight * 0.55,
                    width: DeviceConfig.screenWidth,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    height: DeviceConfig.screenHeight * 0.45,
                    width: DeviceConfig.screenWidth,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/officeGardening.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sh(30.0), vertical: sh(10.0)),
                      child: Text(
                        "Version ${APIpathUtil.version}",
                        style: TextStyle(
                          color: AppColors.brownColor,
                          fontSize: sf(12.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: DeviceConfig.screenHeight,
              width: DeviceConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: sh(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    logoText(20.0),
                    padding(15.0),
                    Text(
                      "Sign in",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: sf(35.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding(40.0),
                    Container(
                      height: sh(320),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: sh(230),
                            padding: EdgeInsets.only(
                              left: sh(30.0),
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.lightPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(sh(20.0)),
                                  bottomLeft: Radius.circular(sh(20.0)),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // padding(25.0),
                                TextField(
                                  controller: _usernameTextController,
                                  focusNode: _usernameFocusNode,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: AppColors.whiteColor),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(
                                        sh(8.0),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor
                                                  .withOpacity(0.4))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor)),
                                      focusColor: AppColors.whiteColor,
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(0.4),
                                        fontSize: sf(18.0),
                                      ),
                                      errorText: _usernameErrorMessage),
                                  onChanged: (value) {
                                    setState(() {
                                      _usernameErrorMessage = null;
                                    });
                                  },
                                ),
                                padding(10.0),
                                TextField(
                                  controller: _passwordTextController,
                                  focusNode: _passwordFocusNode,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(color: AppColors.whiteColor),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(sh(8.0)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor
                                                  .withOpacity(0.4))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor)),
                                      focusColor: AppColors.whiteColor,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(0.4),
                                        fontSize: sf(18.0),
                                      ),
                                      errorText: _passwordErrorMessage),
                                  onChanged: (value) {
                                    setState(() {
                                      _passwordErrorMessage = null;
                                    });
                                  },
                                ),
                                padding(30.0),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sh(30.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  padding: EdgeInsets.all(
                                    sh(22.0),
                                  ),
                                  color: AppColors.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sh(10.0)),
                                  ),
                                  child: _loginIn
                                      ? SizedBox(
                                          height: sh(30.0),
                                          width: sh(30.0),
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                AppColors.primaryColor),
                                            strokeWidth: sf(2.0),
                                          ))
                                      : _loginSuccess
                                          ? Icon(
                                              Icons.check,
                                              color: AppColors.primaryColor,
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      fontSize: sf(18.0),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .primaryColor),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: sf(18.0),
                                                  color: AppColors.primaryColor,
                                                )
                                              ],
                                            ),
                                  onPressed: () {
                                    if (!_loginIn && !_loginSuccess) {
                                      setState(() {
                                        _usernameFocusNode.unfocus();
                                        _passwordFocusNode.unfocus();
                                        _loginIn = true;
                                        _checkInputs();
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: sh(18.0)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(sh(1)),
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(sh(3))),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: Colors.white,
                                          ),
                                          child: SizedBox(
                                            width: sh(20),
                                            height: sh(20),
                                            child: Checkbox(
                                              value: _rememberMe,
                                              checkColor: _rememberMe
                                                  ? AppColors.greenColor
                                                  : AppColors.whiteColor,
                                              activeColor: _rememberMe
                                                  ? AppColors.greenColor
                                                  : AppColors.whiteColor,
                                              onChanged: (v) {
                                                setState(() {
                                                  _rememberMe = !_rememberMe;
                                                });
                                                print(v);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: sw(10.0)),
                                      ),
                                      Text(
                                        'Remember me',
                                        style: TextStyle(
                                            fontSize: sf(15.0),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.whiteColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
