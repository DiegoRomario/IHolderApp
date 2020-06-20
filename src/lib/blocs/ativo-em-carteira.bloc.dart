import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/models/ativo-em-carteira.dart';
import 'package:iholder_app/repositories/ativo-em-carteira.repository.dart';

class AtivoEmCarteiraBloc extends ChangeNotifier {
  AtivoEmCarteiraBloc() {
    obterAtivosEmCarteira();
  }
  List<AtivoEmCarteiraViewModel> ativosEmCarteira;
  var repository = new AtivoEmCarteiraRepository();

  obterAtivosEmCarteira() async {
    await Future.delayed(Duration(seconds: 2));
    ativosEmCarteira = await repository.obterTodos();
    notifyListeners();
  }

  Future<String> salvar(AtivoEmCarteira ativoEmCarteira) async {
    try {
      var response = await repository.salvar(ativoEmCarteira);
      obterAtivosEmCarteira();
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
