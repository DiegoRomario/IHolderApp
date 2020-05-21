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
    loadUser();
  }

  Future<UsuarioViewModel> login(UsuarioLogin login) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var repository = new UsuarioRepository();
      usuario = await repository.login(login);
      await preferences.remove('user');
      await preferences.setString('user', jsonEncode(usuario));
      Settings.user = usuario;
      return usuario;
    } catch (ex) {
      limpaUsuario();
      throw ex;
    }
  }

  Future<UsuarioViewModel> cadastrar(Usuario usuario) async {
    try {
      var repository = new UsuarioRepository();
      return await repository.cadastrar(usuario);
    } catch (ex) {
      limpaUsuario();
      throw ex;
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('user', null);
    limpaUsuario();
    notifyListeners();
  }

  void limpaUsuario() {
    usuario = null;
    Settings.user = null;
  }

  Future loadUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var usuarioString = preferences.getString('user');
    if (usuarioString != null) {
      var response = UsuarioViewModel.fromJson(jsonDecode(usuarioString));
      Settings.user = response;
      usuario = response;
    } else {
      limpaUsuario();
    }
  }
}
