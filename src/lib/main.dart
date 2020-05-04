import 'package:flutter/material.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/screens/tab.screen.dart';

import 'repositories/usuario.respository.dart';

void main() {
  runApp(MyApp());
  final response = UsuarioRepository()
      .Login(
          UsuarioLogin(login: "diego.romario@outlook.com", password: "123456"))
      .then((onValue) {
    debugPrint(onValue.toString());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo[600],
        accentColor: Colors.red[300],
        scaffoldBackgroundColor: Colors.blue[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo[800],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}
