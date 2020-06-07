import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/http/web-client.dart';
import 'package:iholder_app/models/distribuicao-divisao.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/models/distribuicao.dart';
import '../settings.dart';

class DistribuicaoRepository {
  final String sufixoApi;
  DistribuicaoRepository(this.sufixoApi);

  Future<List<DistribuicaoViewModel>> obterTodos() async {
    Response response = await webClient.get(Settings.apiUrl + sufixoApi);
    return (jsonDecode(response.body)["data"] as List)
        .map((course) => DistribuicaoViewModel.fromJson(course))
        .toList();
  }

  Future<String> salvar(Distribuicao distribuicao) async {
    String json = jsonEncode(distribuicao.toJson());
    Response response;

    response = await webClient
        .put(Settings.apiUrl + sufixoApi + "/${distribuicao.id}", body: json);

    return jsonDecode(response.body)["data"];
  }

  Future<String> dividir(DistribuicaoDivisao divisao) async {
    String json = jsonEncode(divisao.toJson());
    Response response;

    response = await webClient.post(Settings.apiUrl + sufixoApi + "/dividir",
        body: json);

    return jsonDecode(response.body)["data"];
  }
}
