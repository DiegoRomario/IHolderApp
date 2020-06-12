import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/models/ativo-em-carteira.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class AtivoEmCarteiraRepository {
  Future<String> salvar(AtivoEmCarteira ativoEmCarteira) async {
    String json = jsonEncode(ativoEmCarteira.toJson());
    Response response;

    if (ativoEmCarteira.id == null) {
      response = await webClient
          .post("${Settings.apiUrl}AtivoEmCarteira/cadastrar", body: json);
    } else {
      response = await webClient.put(
          "${Settings.apiUrl}AtivoEmCarteira/alterar/${ativoEmCarteira.id}",
          body: json);
    }

    return jsonDecode(response.body)["data"];
  }

  Future<List<AtivoEmCarteiraViewModel>> obterTodos() async {
    Response response =
        await webClient.get("${Settings.apiUrl}AtivoEmCarteira");
    var responseJson = jsonDecode(response.body);
    return (responseJson["data"] as List)
        .map((data) => AtivoEmCarteiraViewModel.fromJson(data))
        .toList();
  }
}
