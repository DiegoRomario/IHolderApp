import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/ativo-em-carteira.bloc.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo-em-carteira.screen.dart';
import 'package:iholder_app/ui/shared/widgets/ativo-em-carteira-card-widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:provider/provider.dart';

class AtivosEmCarteiraScreen extends StatefulWidget {
  @override
  _AtivosEmCarteiraScreenState createState() => _AtivosEmCarteiraScreenState();
}

class _AtivosEmCarteiraScreenState extends State<AtivosEmCarteiraScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    var bloc = Provider.of<AtivoEmCarteiraBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Ativos em carteira"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<AtivoEmCarteiraViewModel>>(
        initialData: List(),
        future: bloc.obterAtivosEmCarteira(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loader();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<AtivoEmCarteiraViewModel> ativos = snapshot.data;
              return ativos.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: ativos.length,
                      itemBuilder: (BuildContext context, int index) {
                        final AtivoEmCarteiraViewModel ativo = ativos[index];
                        return Container(
                          child: Column(
                            children: <Widget>[
                              AtivoEmCarteiraCard(bloc, ativo, () {
                                setState(() {});
                              }),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text("Nenhum item encontrado"));
              break;
          }
          return Text("Erro desconhecido");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CadastroAtivoEmCarteiraScreen(bloc))).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
