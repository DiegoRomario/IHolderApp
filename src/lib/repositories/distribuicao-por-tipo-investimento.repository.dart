import 'dart:convert';

import 'package:http/http.dart';
import 'package:iholder_app/http/web-client.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';

import '../settings.dart';

class DistribuicaoPorTipoInvestimentoRepository {
  Future<List<DistribuicaoPorTipoInvestimentoViewModel>> getAll() async {
    var url = "${Settings.apiUrl}DistribuicaoPorTipoInvestimento";
    Response response = await webClient.get(url);

    final responser = jsonDecode(response.body);

    return (responser["data"] as List)
        .map((course) =>
            DistribuicaoPorTipoInvestimentoViewModel.fromJson(course))
        .toList();
  }
}
