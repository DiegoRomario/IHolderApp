import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/http/web-client.dart';
import 'package:iholder_app/models/produto-view-model.dart';
import '../settings.dart';

class ProdutoRepository {
  Future<List<ProdutoViewModel>> obterTodos() async {
    Response response = await webClient.get("${Settings.apiUrl}Produto");

    return (jsonDecode(response.body)["data"] as List)
        .map((course) => ProdutoViewModel.fromJson(course))
        .toList();
  }
}
