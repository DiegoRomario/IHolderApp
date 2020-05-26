import 'package:flutter/material.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/ui/android/screens/ativos.screen.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autorizado.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      body: Settings.usuario != null
          ? OpcoesLancamentos()
          : UsuarioNaoAutorizado(),
    );
  }
}

class OpcoesLancamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: GridView.count(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                      childAspectRatio: .99,
                      children: <Widget>[
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => AtivosScreen(),
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(MdiIcons.basket),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Ativos'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => AtivosScreen(),
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(MdiIcons.cashPlus),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Aportes'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
