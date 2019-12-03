import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';
import 'package:hr_flex/Common/DateUtil.dart';

class EmployeeData {
  static ApiUtil _apiUtil = new ApiUtil();
  static bool response = false;
  static bool hasEmployeeData = false;
  static Map<String, dynamic> employeeProfile;
  static List<dynamic> birthdaysToday;
  static List<dynamic> newHires;
  static int birthdaysTodayListLength;
  static int newHiresListLength;
  static Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  static String employeesURL = APIpathUtil.baseURL + APIpathUtil.employeesPATH;

  //function to get employee profile
  Future<bool> getEmployeeProfile() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(employeesURL + "profile", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        hasEmployeeData = false;
        employeeProfile = {};
        response = false;
      } else {
        hasEmployeeData = true;
        employeeProfile = res["details"];
        APIpathUtil.subscriptionBody["staffNo"] = employeeProfile["id"];
        APIpathUtil.subscriptionBody["emailAddress"] = employeeProfile["email"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get birthday today
  Future<bool> getEmployeeBirthdaysToday() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(employeesURL + "birthdays", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        birthdaysToday = [];
        birthdaysTodayListLength = 0;
        response = false;
      } else {
        birthdaysToday = res["details"];
        if (birthdaysToday.isEmpty) {
          birthdaysTodayListLength = 0;
        } else {
          birthdaysTodayListLength = birthdaysToday.length;
        }
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get new hires
  Future<bool> getNewHires() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(
            employeesURL +
                "joiners?from=${DateUtil().format("yMMMMd", DateUtil().recentMonday())}",
            headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        newHires = [];
        newHiresListLength = 0;
        response = false;
      } else {
        newHires = res["details"];
        if (newHires.isEmpty) {
          newHiresListLength = 0;
        } else {
          newHiresListLength = birthdaysToday.length;
        }
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  resetEmployeeProfile() {
    employeeProfile = null;
    hasEmployeeData = false;
  }
}
