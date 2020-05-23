import 'package:flutter/material.dart';
import 'package:iholder_app/ui/themes/Claro.theme.dart';
import 'package:iholder_app/ui/themes/Escuro.theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings.dart';

class TemaBloc extends ChangeNotifier {
  var tema = claroTheme();

  TemaBloc() {
    carregar();
  }

  salvar(String tema) async {
    var preferencias = await SharedPreferences.getInstance();
    await preferencias.setString('tema', tema);
  }

  alterar(String color) {
    switch (color) {
      case 'Claro':
        {
          defineTemaClaro();
          break;
        }
      case 'Escuro':
        {
          defineTemaEscuro();
          break;
        }
      default:
        {
          defineTemaClaro();
          break;
        }
    }
  }

  void defineTemaEscuro() {
    tema = escuroTheme();
    Settings.tema = "Escuro";
    salvar(Settings.tema);
    notifyListeners();
  }

  void defineTemaClaro() {
    tema = claroTheme();
    Settings.tema = "Claro";
    salvar(Settings.tema);
    notifyListeners();
  }

  Future carregar() async {
    var preferencias = await SharedPreferences.getInstance();
    var tema = preferencias.getString('tema');
    Settings.tema = (tema == null ? 'Claro' : tema);
    alterar(Settings.tema);
  }
}
