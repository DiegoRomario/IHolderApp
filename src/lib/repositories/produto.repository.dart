import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/http/web-client.dart';
import 'package:iholder_app/models/produto-view-model.dart';
import '../settings.dart';

class ProdutoRepository {
  Future<List<ProdutoViewModel>> getAll() async {
    var url = "${Settings.apiUrl}Produto";
    Response response = await webClient.get(url);

    final responser = jsonDecode(response.body);

    return (responser["data"] as List)
        .map((course) => ProdutoViewModel.fromJson(course))
        .toList();
  }
}
