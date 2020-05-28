import 'dart:io';
import 'package:http_interceptor/http_interceptor.dart';
import '../settings.dart';
import 'http.exception.dart';

class LoggingInterceptor implements InterceptorContract {
  // Map<String, String> defaultHeaders = {
  //   HttpHeaders.contentTypeHeader: "application/json",
  //   Settings.usuario == null ? null : HttpHeaders.authorizationHeader:
  //       "Bearer ${Settings.usuario.token}"
  // };

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    if (Settings.usuario != null) {
      data.headers[HttpHeaders.authorizationHeader] =
          "Bearer ${Settings.usuario.token}";
    }

    // print('Request');
    // print('url: ${data.url}');
    // print('headers: ${data.headers}');
    // print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode != 200) {
      throw HttpException(ExceptionConfiguration.getMessage(data));
    }
    // print('Response');
    // print('status code: ${data.statusCode}');
    // print('headers: ${data.headers}');
    // print('body: ${data.body}');
    return data;
  }
}
