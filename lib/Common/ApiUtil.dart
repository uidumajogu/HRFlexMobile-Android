import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//This is the network class that can wrap get and post requests plus handle encoding / decoding of JSONs
class ApiUtil {
  // next three lines makes this class a Singleton
  static ApiUtil _instance = new ApiUtil.internal();
  ApiUtil.internal();
  factory ApiUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, {Map headers}) {
    return http
        .get(
      url,
      headers: headers,
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 204) {
        return {"response": "successful", "details": {}};
      }

      if (statusCode == 200) {
        return {"response": "successful", "details": _decoder.convert(res)};
      }

      if (statusCode != 200 || json == null) {
        return {
          "response": "Error",
          "reason": "Your username or password is not correct"
        };
      } else {
        return {
          "response": "Error",
          "reason": "An error occured, please try again.."
        };
      }
    });
  }

  Future<dynamic> post(String url, {Map headers, body, Encoding encoding}) {
    return http
        .post(url, headers: headers, body: json.encode(body))
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        return {"response": "successful", "details": _decoder.convert(res)};
      }

      if ((statusCode >= 500 && statusCode < 500) || json == null) {
        return {
          "response": "Error",
          "reason": _decoder.convert(res)["message"],
        };
      } else {
        return {
          "response": "Error",
          "reason": _decoder.convert(res)["message"],
        };
      }
    });
  }

  Future<dynamic> patch(String url, {Map headers, body, Encoding encoding}) {
    return http
        .patch(url, headers: headers, body: json.encode(body))
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("response body -- $res,   status code --- $statusCode");

      if (statusCode >= 200 && statusCode < 300) {
        return {"response": "successful", "details": "successful"};
      } else {
        return {
          "response": "Error",
          "reason": _decoder.convert(res)["message"] != null
              ? _decoder.convert(res)["message"]
              : "An error occured",
        };
      }
    });
  }
}
