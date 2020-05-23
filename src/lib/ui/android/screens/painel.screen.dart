import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autorizado.widget.dart';
import 'package:provider/provider.dart';
import 'distribuicao.screen.dart';

class PainelScreen extends StatefulWidget {
  @override
  _PainelScreenState createState() => _PainelScreenState();
}

class _PainelScreenState extends State<PainelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Settings.usuario != null ? OpcoesPaineis() : UsuarioNaoAutorizado(),
    );
  }
}

class OpcoesPaineis extends StatelessWidget {
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
                    builder: (ctx) => DistribuicaoScreen(
                        "Distribuição por tipo",
                        Provider.of<DistribuicaoPorTipoBloc>(context)),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Distribuição por tipo",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.indigo,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DistribuicaoScreen(
                        "Distribuição por ativo",
                        Provider.of<DistribuicaoPorAtivoBloc>(context)),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Distribuição por ativo",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.indigo,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DistribuicaoScreen(
                        "Distribuição por produto",
                        Provider.of<DistribuicaoPorProdutoBloc>(context)),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Distribuição por produto",
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
