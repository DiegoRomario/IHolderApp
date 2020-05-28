import 'package:iholder_app/models/produto-view-model.dart';
import 'package:iholder_app/repositories/produto.repository.dart';


class ProdutoService {
  var produtoRepository = new ProdutoRepository();
  List<ProdutoViewModel> produtos;

  ProdutoService () {
    produtoRepository.obterTodos().then(
      (data) {
        this.produtos = data;
      },
    );
  }

  String obterPorDescricao(String description) {
    ProdutoViewModel produto = produtos.firstWhere((e) => e.descricao == description, orElse: () => null);

    return produto?.id;
  }

  List<String> obterSugestao(String query) {
    List<ProdutoViewModel> matches = List();
    matches.addAll(produtos);

    matches.retainWhere(
        (s) => s.descricao.toLowerCase().contains(query.toLowerCase()));

    var sList = matches.map((val) => val.descricao).toList();

    return sList;
  }
}