import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/aporte-view-model.dart';
import 'package:iholder_app/models/aporte.dart';
import 'package:iholder_app/repositories/Aporte.repository.dart';

class AporteBloc extends ChangeNotifier {
  AporteBloc() {
    obterAportes();
  }
  List<AporteViewModel> aportes;
  var repository = new AporteRepository();

  obterAportes() {
    repository.obterTodos().then((data) {
      aportes = data;
      notifyListeners();
    });
  }

  Future<String> salvar(Aporte aporte) async {
    try {
      var response = await repository.salvar(aporte);
      obterAportes();
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
