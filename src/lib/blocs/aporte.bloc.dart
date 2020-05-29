import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/Aporte-view-model.dart';
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

  // Future<String> salvar(Aporte Aporte) async {
  //   try {
  //     var response = await repository.salvar(Aporte);
  //     obterAportes();
  //     return response;
  //   } catch (ex) {
  //     throw ex;
  //   }
  // }
}
