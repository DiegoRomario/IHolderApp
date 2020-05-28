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
    carregarUsuario();
  }

  Future<UsuarioViewModel> login(UsuarioLogin login) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var repository = new UsuarioRepository();
      usuario = await repository.login(login);
      await preferences.remove('usuario');
      await preferences.setString('usuario', jsonEncode(usuario));
      Settings.usuario = usuario;
      return usuario;
    } catch (ex) {
      limpaUsuario();
      throw ex;
    }
  }

  Future<UsuarioViewModel> cadastrar(Usuario usuario) async {
    try {
      var repository = new UsuarioRepository();
      return await repository.salvar(usuario);
    } catch (ex) {
      limpaUsuario();
      throw ex;
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('usuario', null);
    limpaUsuario();
    notifyListeners();
  }

  void limpaUsuario() {
    usuario = null;
    Settings.usuario = null;
  }

  Future carregarUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var usuarioString = preferences.getString('usuario');
    if (usuarioString != null) {
      var response = UsuarioViewModel.fromJson(jsonDecode(usuarioString));
      Settings.usuario = response;
      usuario = response;
    } else {
      limpaUsuario();
    }
  }
}
