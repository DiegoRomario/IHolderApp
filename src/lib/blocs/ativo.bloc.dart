import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  AtivoBloc() {
    obterAtivos();
  }
  List<AtivoViewModel> ativos = new List();
  var repository = new AtivoRepository();

  obterAtivos() {
    repository.obterTodos().then((data) {
      ativos = data;
      notifyListeners();
    });
  }

  Future<String> salvar(Ativo ativo) async {
    try {
      var response = await repository.salvar(ativo);
      obterAtivos();
      return response;
    } catch (ex) {
      throw ex;
    }
  }
  
}
