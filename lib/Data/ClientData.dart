import 'package:hr_flex/Common/APIpathUtil.dart';
import 'package:hr_flex/Common/ApiUtil.dart';

class ClientData {
  static ApiUtil _apiUtil = new ApiUtil();
  static bool response = false;
  static Map<String, dynamic> clientDetails;
  static Map<String, dynamic> headers = APIpathUtil.getHEADERS;
  static String clientsURL = APIpathUtil.baseURL + APIpathUtil.clientsPATH;

  //function to get client data
  Future<bool> getClientProfile() async {
    if (clientDetails != null) return true;

    headers["authorization"] =
        APIpathUtil.addPath + APIpathUtil.accessToken["accessToken"];
    return _apiUtil
        .get(clientsURL + "profile", headers: headers)
        .then((dynamic res) {
      if (res["response"] == "Error") {
        clientDetails = {};
        response = false;
      } else {
        clientDetails = res["details"];

        APIpathUtil.subscriptionBody["clientId"] = clientDetails["id"];
        response = true;
      }
    }).then((_) {
      return response;
    });
  }
}
