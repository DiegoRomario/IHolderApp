import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/produto-view-model.dart';
import 'package:iholder_app/repositories/produto.repository.dart';

class ProdutoBloc extends ChangeNotifier {
  var produtoRepository = new ProdutoRepository();
  List<ProdutoViewModel> produtos;

  ProdutoBloc() {
    produtos = new List<ProdutoViewModel>();
    obterProdutos();
  }

  String obterPorDescricao(String description) {
    ProdutoViewModel produto = produtos
        .firstWhere((e) => e.descricao == description, orElse: () => null);

    return produto?.id;
  }

  Future obterProdutos() async {
    if (this.produtos.length == 0) {
      await produtoRepository.obterTodos().then(
        (data) {
          this.produtos = data;
        },
      );
    }
  }

  Future<List<String>> obterSugestao(String query) async {
    List<ProdutoViewModel> matches = List();

    await obterProdutos();

    matches.addAll(produtos);

    matches.retainWhere(
        (s) => s.descricao.toLowerCase().contains(query.toLowerCase()));

    List<String> sList = matches.map((val) => val.descricao).toList();

    return sList;
  }
}
