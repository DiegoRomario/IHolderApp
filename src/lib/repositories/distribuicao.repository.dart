import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/http/web-client.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
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
}
