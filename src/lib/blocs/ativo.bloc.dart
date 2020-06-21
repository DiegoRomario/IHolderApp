import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  var repository = new AtivoRepository();
  List<AtivoViewModel> ativos;
  AtivoBloc();

  // obterAtivos() async {
  //   this.ativos = await repository.obterTodos();
  //   debugPrint("pronto" + this.ativos.length.toString());
  //   notifyListeners();
  // }

  Future<List<AtivoViewModel>> obterAtivos() async {
    try {
      List<AtivoViewModel> result = await repository.obterTodos();
      print("demo");
      return result;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> salvar(Ativo ativo) async {
    try {
      var response = await repository.salvar(ativo);
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> alterarSituacao(AtivoViewModel ativo) async {
    try {
      var response = await repository.alterarSituacao(ativo);
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
