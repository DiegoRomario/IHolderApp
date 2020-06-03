import 'dart:convert';

import 'package:http_interceptor/models/response_data.dart';

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}

class ExceptionConfiguration {
  static String getMessage(ResponseData data) {
    if (data.statusCode == 400) {
      List errors = (jsonDecode(data.body)["errors"] as List);
      String errorMessages = "";
      errors.forEach((element) {
        errorMessages = errorMessages + element.toString() + " /";
      });
      return errorMessages.substring(0, errorMessages.length - 1);
    }
    return _statusCodeResponses[data.statusCode];
  }

  static final Map<int, String> _statusCodeResponses = {
    401: 'Falha de autenticação',
    409: 'Ocorreu um conflito no servidor',
    500: 'Erro interno no servidor'
  };
}
