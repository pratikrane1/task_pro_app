import 'dart:convert';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/util/app_constants.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  String? token;

  final SharedPreferences sharedPreferences;
  ApiClient({
    required this.appBaseUrl,required this.sharedPreferences
  }){
    print("TOKEN: $token");
    // token = sharedPreferences.getString(AppConstants.USER_TOKEN) ?? Get.find<AuthController>().getUserToken();
    token = sharedPreferences.getString(AppConstants.USER_TOKEN);
    updateHeader(token ?? "",
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE).toString()
    );
  }
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;
  Map<String, String>? _mainHeaders;

  void updateHeader(String token, String languageCode,) {
    Map<String, String> _header = {
      'Authorization': 'Bearer $token',
      'device' : 'Android',
      AppConstants.LOCALIZATION_KEY: languageCode != "" ? languageCode : AppConstants.languages[0].languageCode,
    };

    _mainHeaders = _header;
  }

  Future<Response> getData(String uri) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
      }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl +  uri),
          headers: _mainHeaders
      ).timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body);
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> getLocationData(String uri) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
      }
      Http.Response _response = await Http.get(
        Uri.parse(uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body);
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        // body: jsonEncode(body),
        body: body,
          headers: _mainHeaders
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postYoutubeApi(String uri,) async {
    try {
      // if (Foundation.kDebugMode) {
      //   print('====> API Body: $body');
      // }
      Http.Response _response = await Http.get(
        Uri.parse(uri),
        // body: jsonEncode(body),
        // body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postCouponData(String uri, body) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Body: ${jsonEncode(body)}');
      }
      Http.Response _response = await Http.post(
        Uri.parse(uri),
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postRazorPayData(String uri, dynamic body) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(uri),
        // body: jsonEncode(body),
        body: body,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postRazorPayOrderId(String uri, dynamic body) async {
    String? basicAuth;
    String username = 'rzp_live_YPqi3Ls1a4tYhP';
    String password = 'AYwIluiPkLATXU8JYe0nzNYc';
    basicAuth = base64.encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      if (Foundation.kDebugMode) {
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(uri),
        // body: jsonEncode(body),
        body: jsonEncode(body),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic cnpwX2xpdmVfWVBxaTNMczFhNHRZaFA6QVl3SWx1aVBrTEFUWFU4SlllMG56Tllj'
        }
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
    String uri,
    Map<String, String> body,
    String file,
  ) async {
    try {

      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      var userProfileImg = await Http.MultipartFile.fromPath(
          'image', file);
      _request.files.add(userProfileImg);
      _request.fields.addAll(body);
      _request.headers.addAll(_mainHeaders!);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        // ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
          statusCode: _response.statusCode,
          body: _response.body,
        );
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (Foundation.kDebugMode) {
      print(
          '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }
}

