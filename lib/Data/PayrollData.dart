import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';

class PayrollData {
  static bool hasPayrollData = false;
  static ApiUtil _apiUtil = new ApiUtil();
  static bool response = false;
  static Map<String, dynamic> payslip;
  static Map<String, dynamic> currentPayslipDateData;
  static Map<String, dynamic> minPayslipDateData;
  static Map<String, dynamic> payslipReportMinRange;
  static Map<String, dynamic> payslipReportMaxRange;
  static List<dynamic> payrollPeriod;
  static Map<String, dynamic> taxRemittance;
  static Map<String, dynamic> pensionRemittance;
  static Map<String, dynamic> nhfRemittance;
  static Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  static String payrollURL = APIpathUtil.baseURL + APIpathUtil.payrollPATH;
  static bool reportRequestHasEndDate;
  static bool reportRequestHasStartDate;

  //function to get payroll periods
  Future<bool> getParoll() async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil.get(payrollURL, headers: headers).then((dynamic res) {
      if (res["response"] == "Error") {
        hasPayrollData = false;
        payrollPeriod = [];
        currentPayslipDateData = {};
        minPayslipDateData = {};
        payslip = {};
        response = false;
      } else {
        hasPayrollData = true;
        payrollPeriod = res["details"];
        if (payrollPeriod.isNotEmpty) {
          int greaterID = 0;
          int lesserID = 1000000;
          for (var i = 0; i < payrollPeriod.length; i++) {
            if (payrollPeriod[i]["id"] > greaterID) {
              greaterID = payrollPeriod[i]["id"];
              currentPayslipDateData = payrollPeriod[i];
              payslipReportMaxRange = currentPayslipDateData;
            }

            if (payrollPeriod[i]["id"] < lesserID) {
              lesserID = payrollPeriod[i]["id"];
              minPayslipDateData = payrollPeriod[i];
              payslipReportMinRange = minPayslipDateData;
            }
          }
        } else {
          hasPayrollData = false;
          payrollPeriod = [];
          currentPayslipDateData = {};
          minPayslipDateData = {};
          payslip = {};
        }
        response = true;
      }
    }).then((res) {
      return response;
    });
  }

  //function to get payroll payslip
  Future<bool> getPayslip(String month, String year) async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(payrollURL + "payslip?month=" + month + "&year=" + year,
            headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        payslip = {};
        response = false;
      } else {
        payslip = res["details"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  assignRemittance(type, value) {
    if (type == "Tax") {
      taxRemittance = value;
    }
    if (type == "Nhf") {
      nhfRemittance = value;
    }
    if (type == "Pension") {
      pensionRemittance = value;
    }
  }

  //function to get remittances
  Future<bool> getRemittances(String type) async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(payrollURL + "remittances/" + type, headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        response = false;
        assignRemittance(type, {});
      } else {
        assignRemittance(type, res["details"]);
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  //function to send payroll info
  Future<bool> sendPayrollInfo(String type, String querry) async {
    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    String url = payrollURL + "report/" + type;
    if (querry != "none") {
      url = payrollURL + "report/" + type + querry;
    }

    return _apiUtil.post(url, headers: headers).then((dynamic res) {
      if (res["response"] == "Error") {
        response = false;
      } else {
        response = true;
      }
    }).then((_) {
      return response;
    });
  }

  updatePayslipReportMinRange(String min) {
    if (min == "none") {
      payslipReportMinRange = minPayslipDateData;
    } else {
      for (var i = 0; i < payrollPeriod.length; i++) {
        if (payrollPeriod[i]["title"] == min) {
          payslipReportMinRange = payrollPeriod[i];
        }
      }
    }
  }

  updatePayslipReportMaxRange(String max) {
    if (max == "none") {
      payslipReportMaxRange = currentPayslipDateData;
    } else {
      for (var i = 0; i < payrollPeriod.length; i++) {
        if (payrollPeriod[i]["title"] == max) {
          payslipReportMaxRange = payrollPeriod[i];
        }
      }
    }
  }

  resetRangeValues() {
    PayrollData.payslipReportMaxRange = PayrollData.currentPayslipDateData;
    PayrollData.payslipReportMinRange = PayrollData.minPayslipDateData;
    PayrollData.reportRequestHasStartDate = false;
    PayrollData.reportRequestHasEndDate = false;
  }

  resetPayrollPeriod() {
    payrollPeriod = null;
    hasPayrollData = false;
  }
}
