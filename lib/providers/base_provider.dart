import 'dart:convert';

import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;

    httpClient.addRequestModifier<dynamic>((request) async{
      request.headers['auth-token'] = Constants.user?.authToken??'';
      if (request.method == 'post') {
        List<int> bodyData = [];
        await for (var chunk in request.bodyBytes) {
          bodyData.addAll(chunk);
        }
        final requestBody = utf8.decode(bodyData);
        Logger().d('Method: ${request.method}\nUrl: ${request.url}\nFiles: ${request.files}\nBody: $requestBody');

      }else{
        Logger().d('Method: ${request.method}\nUrl: ${request.url}\nFiles: ${request.files}');
      }
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) {
      final responseMeta = {
        'hasError':response.status.hasError,
        'Code':response.status.code,
        'isOk':response.status.isOk,
        'isForbidden':response.status.isForbidden,
        'isNotFound':response.status.isNotFound,
        'isServerError':response.status.isServerError,
        'isUnauthorized':response.status.isUnauthorized,
        'isBlank':'${response.status.isBlank}',
        'connectionError':response.status.connectionError,
      };
      Logger().d('Response: ${response.bodyString}\nCode:${response.statusCode}\nStatus: ${response.statusText}\nOther: $responseMeta');
      /*if (response.statusCode == 401) {
        showSnackBar(message: 'Session expired. Please login again', success: false);
      }*/
      return response;
    });
  }

  void defaultDecoderWhenError(dynamic map) {
    if (map is Map) {
      if (map.containsKey('message')) {
        showSnackBar(message: map['message'], success: false);
      } else if (map.containsKey('errors')) {
        showSnackBar(message: map['errors'], success: false);
      } else {
        showSnackBar(message: 'Unknown Error Occurred', success: false);
      }
    }
  }
}
