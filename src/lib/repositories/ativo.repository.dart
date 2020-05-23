import 'dart:convert';
import 'dart:io';
import 'package:iholder_app/http/http.exception.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class AtivoRepository {
  Future<String> cadastrar(Ativo ativo) async {
    final String ativoJson = jsonEncode(ativo.toJson());
    final response = await webClient.post("${Settings.apiUrl}Ativo/cadastrar",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Settings.usuario.token}"
        },
        body: ativoJson);

    if (response.statusCode == 200) {
      final responser = jsonDecode(response.body);
      return responser["data"];
    }

    throw HttpException(ExceptionConfiguration.getMessage(response.statusCode));
  }
}
