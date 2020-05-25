import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:iholder_app/http/http.exception.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class AtivoRepository {
  Future<String> salvar(Ativo ativo) async {
    final String ativoJson = jsonEncode(ativo.toJson());
    Response response;

    if (ativo.id == null) {
      response = await webClient.post("${Settings.apiUrl}Ativo/cadastrar",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Settings.usuario.token}"
          },
          body: ativoJson);
    } else {
      response =
          await webClient.put("${Settings.apiUrl}Ativo/alterar/${ativo.id}",
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${Settings.usuario.token}"
              },
              body: ativoJson);
    }

    if (response.statusCode == 200) {
      final responser = jsonDecode(response.body);
      return responser["data"];
    }

    throw HttpException(ExceptionConfiguration.getMessage(response.statusCode));
  }

  Future<List<AtivoViewModel>> obterAtivos() async {
    Response response = await webClient.get("${Settings.apiUrl}Ativo");
    var responseJson = jsonDecode(response.body);
    return (responseJson["data"] as List)
        .map((data) => AtivoViewModel.fromJson(data))
        .toList();
  }
}
