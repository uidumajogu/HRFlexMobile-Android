import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';

class LeaveData {
  static ApiUtil _apiUtil = new ApiUtil();
  static bool response = false;
  static List<dynamic> leaveTypes;
  static Map<dynamic, dynamic> employeeLeaveCalendar;
  static List<dynamic> employeeLeaveTeamCalendar;
  static List<dynamic> holidays;
  static List<dynamic> reliefOfficers;
  static List<dynamic> employeeLeaveTasks;
  static Map<dynamic, dynamic> reliefOfficerData;
  static String selectedStartDate;
  static String selectedLeaveDays;
  static Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  static String leaveURL = APIpathUtil.baseURL + APIpathUtil.leavePATH;
  static String employeesURL = APIpathUtil.baseURL + APIpathUtil.employeesPATH;

  //function to Get leave types available for the employee
  Future<bool> getLeaveTypes() async {
    reliefOfficerData = {};

    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil.get(leaveURL, headers: headers).then((dynamic res) {
      if (res["response"] == "Error") {
        leaveTypes = [];
        response = false;
      } else {
        leaveTypes = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get employee leave calendar
  Future<bool> getEmployeeLeaveCalendar() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(leaveURL + "calendar", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        employeeLeaveCalendar = {};
        response = false;
      } else {
        employeeLeaveCalendar = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get employee leave team calendar
  Future<bool> getEmployeeLeaveTeamCalendar() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(leaveURL + "calendar/team", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        employeeLeaveTeamCalendar = [];
        response = false;
      } else {
        employeeLeaveTeamCalendar = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get holidays
  Future<bool> getHolidays() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(leaveURL + "holidays", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        holidays = [];
        response = false;
      } else {
        holidays = res["details"];
        response = true;
      }
    }).then((_) {
      print("holidays -- -- $holidays");
      return response;
    });
  }

  //function to get leave tasks
  Future<bool> getEmployeeLeaveTasks() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(leaveURL + "tasks", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        employeeLeaveTasks = [];
        response = false;
      } else {
        employeeLeaveTasks = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to get relief officers
  Future<bool> getReliefOfficers(String query) async {
    if (query == "") {
      reliefOfficers = [];
      return false;
    }
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(employeesURL + "reliefofficers?search=" + query, headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        reliefOfficers = [];
        response = false;
      } else {
        reliefOfficers = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  updateReliefOfficerData(rod) {
    reliefOfficerData = rod;
  }

  Map<dynamic, dynamic> getReliefOfficerData() {
    return reliefOfficerData;
  }
}
