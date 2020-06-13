import 'package:flutter/material.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/ui/android/screens/ativo-em-carteira.screen.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo.screen.dart';
import 'package:iholder_app/ui/android/screens/cadastro-distribuicao.screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'descricao-e-widget.widget.dart';

class AtivoCard extends StatefulWidget {
  final AtivoViewModel ativo;

  const AtivoCard(this.ativo);
  @override
  _AtivoCardState createState() => _AtivoCardState();
}

class _AtivoCardState extends State<AtivoCard> {
  bool mostraDetalhes = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroAtivoScreen(
                              ativoViewModel: widget.ativo,
                            )));
              },
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.ativo.ticker),
                      Text(" - "),
                      Text(
                        widget.ativo.descricao,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          DescricaoEWidget(
                            "Tipo",
                            Text(widget.ativo.tipoDescricao),
                          ),
                          DescricaoEWidget(
                            "Produto",
                            Text(widget.ativo.produtoDescricao),
                          ),
                          DescricaoEWidget(
                            "Situação",
                            Text(widget.ativo.situacao),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  width: 55,
                  child: FlatButton(
                    child: Icon(mostraDetalhes
                        ? MdiIcons.chevronUp
                        : MdiIcons.chevronDown),
                    onPressed: () {
                      setState(() {
                        mostraDetalhes = !mostraDetalhes;
                      });
                    },
                  ),
                ),
                isThreeLine: false,
              ),
            ),
            Visibility(
              visible: mostraDetalhes,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Text(widget.ativo.caracteristicas),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(MdiIcons.walletPlus),
                              tooltip: 'Abrir ativos em carteira',
                              onPressed: () {
                                {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          AtivosEmCarteiraScreen(),
                                    ),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(MdiIcons.divisionBox),
                              tooltip: 'Abrir divisão por ativos',
                              onPressed: () {
                                {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          CadastroDistribuicaoScreen(
                                              "Cadastro de distribuições"),
                                    ),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(MdiIcons.cogOutline),
                              tooltip: 'Configurar situação do',
                              onPressed: () {
                                situacaoShowDialog(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

situacaoShowDialog(BuildContext context) {
  Widget normalButton = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(MdiIcons.checkboxMarked),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Regular'),
        )
      ],
    ),
  );
  Widget oportunidadeButton = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(MdiIcons.lightbulbOn),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Oportunidade'),
        )
      ],
    ),
  );
  Widget quarentenaButton = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(MdiIcons.virus),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Quarentena'),
        )
      ],
    ),
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Para qual situação deseja alterar o ativo?"),
    actions: [
      normalButton,
      oportunidadeButton,
      quarentenaButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
