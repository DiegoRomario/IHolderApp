import 'dart:convert';
import 'package:http/src/response.dart';
import 'package:iholder_app/http/http.exception.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/http/web-client.dart';

class UsuarioRepository {
  Future<UsuarioViewModel> Login(UsuarioLogin usuarioLogin) async {
    final String usuarioLoginJson = jsonEncode(usuarioLogin.toJson());
    final Response response =
        await webClient.post("${Settings.apiUrl}Usuario/entrar",
            headers: {
              'Content-type': 'application/json',
            },
            body: usuarioLoginJson);

    if (response.statusCode == 200) {
      final responser = jsonDecode(response.body);
      return UsuarioViewModel.fromJson(responser["data"]);
    }

    throw HttpException(ExceptionConfiguration.getMessage(response.statusCode));
  }
}

