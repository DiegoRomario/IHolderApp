import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  Future<String> cadastrar(Ativo ativo) async {
    try {
      var repository = new AtivoRepository();
      return await repository.cadastrar(ativo);
    } catch (ex) {
      throw ex;
    }
  }
}
