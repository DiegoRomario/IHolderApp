import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../settings.dart';
import 'logging-interceptor.dart';

final Client webClient = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 30),
);

final Map<String, String> defaultHeaders = {
  HttpHeaders.contentTypeHeader: "application/json",
  Settings.usuario == null ? null : HttpHeaders.authorizationHeader:
      "Bearer ${Settings.usuario.token}"
};
