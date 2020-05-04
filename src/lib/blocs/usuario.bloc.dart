import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/repositories/usuario.respository.dart';
import 'package:iholder_app/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  UsuarioViewModel usuario;
  SharedPreferences preferences;

  UserBloc() {
    usuario = new UsuarioViewModel();
    SharedPreferences.getInstance().then((onValue) {
      preferences = onValue;
    });
    loadUser();
  }
  Future<UsuarioViewModel> login(UsuarioLogin login) async {
    try {
      var repository = new UsuarioRepository();
      usuario = await repository.Login(login);
      await preferences.setString('user', jsonDecode(usuario.toString()));
      return usuario;
    } catch (ex) {
      usuario = null;
      return null;
    }
  }

  logout() async {
    await preferences.setString('user', null);
    usuario = null;
    notifyListeners();
  }

  Future loadUser() async {
    var usuarioString = preferences.getString('user');
    if (usuarioString != null) {
      var response = UsuarioViewModel.fromJson(jsonDecode(usuarioString));
      Settings.user = response;
      usuario = response;
    }
  }
}
