import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/aporte.bloc.dart';
import 'package:iholder_app/models/aporte-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-aporte.screen.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo.screen.dart';
import 'package:iholder_app/ui/shared/widgets/aporte-card-widget.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

class AportesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AporteBloc>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Aportes"),
        centerTitle: true,
      ),
      body: DataLoader(
        object: bloc.aportes,
        callback: () {
          return AportesListagem(
            ativos: bloc.aportes,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroAporteScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AportesListagem extends StatelessWidget {
  final List<AporteViewModel> ativos;
  AportesListagem({this.ativos});
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
                    AporteCard(
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
