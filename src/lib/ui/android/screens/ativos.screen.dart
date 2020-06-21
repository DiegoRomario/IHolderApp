import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/ativo.bloc.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo.screen.dart';
import 'package:iholder_app/ui/shared/widgets/ativo-card.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:provider/provider.dart';

class AtivosScreen extends StatefulWidget {
  @override
  _AtivosScreenState createState() => _AtivosScreenState();
}

class _AtivosScreenState extends State<AtivosScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    var bloc = Provider.of<AtivoBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Ativos"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<AtivoViewModel>>(
        initialData: List(),
        future: bloc.obterAtivos(),
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
              final List<AtivoViewModel> ativos = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: ativos.length,
                itemBuilder: (BuildContext context, int index) {
                  final AtivoViewModel ativo = ativos[index];
                  return Container(
                    child: Column(
                      children: <Widget>[
                        AtivoCard(bloc, ativo, _scaffoldKey, () {
                          setState(() {
                            print("teste");
                          });
                        }),
                      ],
                    ),
                  );
                },
              );
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
                  builder: (context) => CadastroAtivoScreen(bloc)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
