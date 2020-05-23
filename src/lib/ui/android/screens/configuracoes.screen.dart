import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/tema.bloc.dart';
import 'package:iholder_app/settings.dart';
import 'package:provider/provider.dart';

class ConfiguracoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tema"),
        centerTitle: true,
      ),
      body: SeletorDeTema(),
    );
  }
}

class SeletorDeTema extends StatefulWidget {
  SeletorDeTema({Key key}) : super(key: key);

  @override
  _SeletorDeTemaState createState() => _SeletorDeTemaState();
}

class _SeletorDeTemaState extends State<SeletorDeTema> {
  String _tema = Settings.tema;

  Widget build(BuildContext context) {
    final bloc = Provider.of<TemaBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                width: 150,
                child: ListTile(
                  title: Text('Claro'),
                  leading: Radio(
                    value: 'Claro',
                    groupValue: _tema,
                    onChanged: (String value) {
                      setState(() {
                        bloc.alterar(value);
                        _tema = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 150,
                child: ListTile(
                  title: Text('Escuro'),
                  leading: Radio(
                    value: 'Escuro',
                    groupValue: _tema,
                    onChanged: (String value) {
                      setState(() {
                        bloc.alterar(value);
                        _tema = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
