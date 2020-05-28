import 'dart:convert';
import 'package:http/http.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/models/usuario.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class UsuarioRepository {
  Future<UsuarioViewModel> login(UsuarioLogin usuarioLogin) async {
    String json = jsonEncode(usuarioLogin.toJson());
    Response response =
        await webClient.post("${Settings.apiUrl}Usuario/entrar", body: json);

    return UsuarioViewModel.fromJson(jsonDecode(response.body)["data"]);
  }

  Future<UsuarioViewModel> salvar(Usuario usuario) async {
    String json = jsonEncode(usuario.toJson());
    final response =
        await webClient.post("${Settings.apiUrl}Usuario/cadastrar", body: json);

    return UsuarioViewModel.fromJson(jsonDecode(response.body)["data"]);
  }
}
