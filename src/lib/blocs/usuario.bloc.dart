import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/models/usuario.dart';
import 'package:iholder_app/repositories/usuario.respository.dart';
import 'package:iholder_app/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioBloc extends ChangeNotifier {
  UsuarioViewModel usuario;

  UsuarioBloc() {
    usuario = null;
    loadUser();
  }

  Future<UsuarioViewModel> login(UsuarioLogin login) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var repository = new UsuarioRepository();
      usuario = await repository.login(login);
      await preferences.setString('user', jsonEncode(usuario));
      return usuario;
    } catch (ex) {
      usuario = null;
      throw ex;
    }
  }

  Future<UsuarioViewModel> cadastrar(Usuario usuario) async {
    try {
      var repository = new UsuarioRepository();
      return await repository.cadastrar(usuario);
    } catch (ex) {
      usuario = null;
      throw ex;
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('user', null);
    usuario = null;
    notifyListeners();
  }

  Future loadUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var usuarioString = preferences.getString('user');
    if (usuarioString != null) {
      var response = UsuarioViewModel.fromJson(jsonDecode(usuarioString));
      Settings.user = response;
      usuario = response;
    }
  }
}
