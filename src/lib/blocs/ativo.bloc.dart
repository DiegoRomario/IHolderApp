import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  AtivoBloc() {
    obterAtivos();
  }
  List<AtivoViewModel> ativos;
  var repository = new AtivoRepository();

  obterAtivos() {
    repository.obterAtivos().then((data) {
      ativos = data;
      notifyListeners();
    });
  }

  Future<String> cadastrar(Ativo ativo) async {
    try {
      return await repository.cadastrar(ativo);
    } catch (ex) {
      throw ex;
    }
  }
}
