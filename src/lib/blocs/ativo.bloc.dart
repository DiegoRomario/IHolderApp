import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  var repository = new AtivoRepository();
  bool forcaAtualizacao = false;
  List<AtivoViewModel> ativos;
  AtivoBloc() {
    ativos = new List<AtivoViewModel>();
  }

  // obterAtivos() async {
  //   this.ativos = await repository.obterTodos();
  //   debugPrint("pronto" + this.ativos.length.toString());
  //   notifyListeners();
  // }

  Future<List<AtivoViewModel>> obterAtivos() async {
    try {
      if (ativos.length == 0 || forcaAtualizacao) {
        ativos = await repository.obterTodos();
      }
      forcaAtualizacao = false;
      return ativos;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> salvar(Ativo ativo) async {
    try {
      var response = await repository.salvar(ativo);
      forcaAtualizacao = true;
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> alterarSituacao(AtivoViewModel ativo) async {
    try {
      var response = await repository.alterarSituacao(ativo);
      forcaAtualizacao = true;
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
