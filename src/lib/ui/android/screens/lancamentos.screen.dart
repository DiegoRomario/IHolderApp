import 'package:flutter/material.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autorizado.widget.dart';
import 'cadastro-ativo.screen.dart';

class LancamentosScreen extends StatefulWidget {
  @override
  _LancamentosScreenState createState() => _LancamentosScreenState();
}

class _LancamentosScreenState extends State<LancamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lançamentos"),
        centerTitle: true,
      ),
      body:
          Settings.user != null ? OpcoesLancamentos() : UsuarioNaoAutorizado(),
    );
  }
}

class OpcoesLancamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Material(
            color: Colors.indigo,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CadastroAtivoScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Ativos",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
