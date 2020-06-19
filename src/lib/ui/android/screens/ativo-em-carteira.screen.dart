import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/ativo-em-carteira.bloc.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo-em-carteira.screen.dart';
import 'package:iholder_app/ui/shared/widgets/ativo-em-carteira-card-widget.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

class AtivosEmCarteiraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AtivoEmCarteiraBloc>(context, listen: true);
    //await bloc.initializationDone();
    return Scaffold(
      appBar: AppBar(
        title: Text("Ativos em carteira"),
        centerTitle: true,
      ),
      body: DataLoader(
        object: bloc.ativosEmCarteira,
        callback: () {
          return AtivosEmCarteiraListagem(
            bloc,
            ativos: bloc.ativosEmCarteira,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroAtivoEmCarteiraScreen(bloc),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AtivosEmCarteiraListagem extends StatelessWidget {
  final AtivoEmCarteiraBloc bloc;
  final List<AtivoEmCarteiraViewModel> ativos;
  AtivosEmCarteiraListagem(this.bloc, {this.ativos});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: ativos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    AtivoEmCarteiraCard(
                      bloc,
                      ativos[index],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
