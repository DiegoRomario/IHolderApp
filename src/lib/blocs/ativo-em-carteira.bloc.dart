import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/models/ativo-em-carteira.dart';
import 'package:iholder_app/repositories/ativo-em-carteira.repository.dart';

class AtivoEmCarteiraBloc extends ChangeNotifier {
  var repository = new AtivoEmCarteiraRepository();
  bool forcaAtualizacao = false;
  List<AtivoEmCarteiraViewModel> ativosEmCarteira;
  AtivoEmCarteiraBloc() {
    ativosEmCarteira = new List<AtivoEmCarteiraViewModel>();
  }

  // obterAtivosEmCarteira() async {
  //   ativosEmCarteira = await repository.obterTodos();
  //   notifyListeners();
  // }

  Future<List<AtivoEmCarteiraViewModel>> obterAtivosEmCarteira() async {
    try {
      if (ativosEmCarteira.length == 0 || forcaAtualizacao) {
        ativosEmCarteira = await repository.obterTodos();
      }
      return ativosEmCarteira;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> salvar(AtivoEmCarteira ativoEmCarteira) async {
    try {
      var response = await repository.salvar(ativoEmCarteira);
      forcaAtualizacao = true;
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
