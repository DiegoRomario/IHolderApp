import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/models/cotacao-view-model.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class AtivoRepository {
  Future<String> salvar(Ativo ativo) async {
    String json = jsonEncode(ativo.toJson());
    Response response;

    if (ativo.id == null) {
      response =
          await webClient.post("${Settings.apiUrl}Ativo/cadastrar", body: json);
    } else {
      response = await webClient
          .put("${Settings.apiUrl}Ativo/alterar/${ativo.id}", body: json);
    }

    return jsonDecode(response.body)["data"];
  }

  Future<List<AtivoViewModel>> obterTodos() async {
    Response response = await webClient.get("${Settings.apiUrl}Ativo");
    return (jsonDecode(response.body)["data"] as List)
        .map((data) => AtivoViewModel.fromJson(data))
        .toList();
  }

  Future<CotacaoViewModel> consultarCotacao(
      String ticker, String produto) async {
    Response response = await webClient.get(
        "${Settings.apiUrl}Ativo/consultar-cotacao?ticker=$ticker&produtoDescricao=$produto");
    var responseJson = jsonDecode(response.body);
    return CotacaoViewModel.fromJson(responseJson["data"]);
  }

  Future<String> alterarSituacao(AtivoViewModel ativo) async {
    String json = jsonEncode(ativo.toJson());
    Response response;

    response = await webClient.put(
        "${Settings.apiUrl}Ativo/alterar-situacao/${ativo.id}",
        body: json);

    return jsonDecode(response.body)["data"];
  }
}
