import 'dart:math';

import 'models/produto-view-model.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {'name': query + index.toString(), 'price': Random().nextInt(100)};
    });
  }
}

class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class ProdutosService {
  static final List<ProdutoViewModel> produtos = [
    new ProdutoViewModel(
        id: 'e06a5753-0c15-4294-9b00-3bc54772f090', descricao: 'Renda Fix1'),
    new ProdutoViewModel(
        id: 'e06a5753-0c15-4294-9b00-3bc54772f092', descricao: 'Renda Fix4'),
    new ProdutoViewModel(
        id: 'e06a5753-0c15-4294-9b00-3bc54772f091', descricao: 'Renda Fix3'),
    new ProdutoViewModel(
        id: 'e06a5753-0c15-4294-9b00-3bc54772f099', descricao: 'Renda Fixa2')
  ];

  static String getByDescription(String description) {
    ProdutoViewModel produto = produtos.firstWhere((e) => e.descricao == description, orElse: () => null);

    return produto?.id;
  }

  static List<String> getSuggestions(String query) {
    List<ProdutoViewModel> matches = List();
    matches.addAll(produtos);

    matches.retainWhere(
        (s) => s.descricao.toLowerCase().contains(query.toLowerCase()));

    var sList = matches.map((val) => val.descricao).toList();

    return sList;
  }
}
