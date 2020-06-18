import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/ativo.bloc.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/android/screens/ativo-em-carteira.screen.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo.screen.dart';
import 'package:iholder_app/ui/android/screens/cadastro-distribuicao.screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'descricao-e-widget.widget.dart';
import 'loader.widget.dart';

class AtivoCard extends StatefulWidget {
  final AtivoViewModel ativo;
  final GlobalKey<ScaffoldState> scaffoldKey;
  AtivoCard(this.ativo, this.scaffoldKey);
  @override
  _AtivoCardState createState() => _AtivoCardState();
}

class _AtivoCardState extends State<AtivoCard> {
  bool mostraDetalhes = false;
  var _sending = false;
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
                                          CadastroDistribuicaoScreen(ETipoDistribuicao.ativo),
                                    ),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(MdiIcons.cogOutline),
                              tooltip: 'Configurar situação do',
                              onPressed: () async {
                                await situacaoShowDialog(context);
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

  alterarSituacao(String situacao) async {
    widget.ativo.situacao = situacao;
    var bloc = Provider.of<AtivoBloc>(context, listen: false);
    String response = await bloc.alterarSituacao(widget.ativo).catchError(
      (onError) {
        final snackBar = SnackBar(content: Text(onError.message));
        widget.scaffoldKey.currentState.showSnackBar(snackBar);
      },
    );

    if (response != null) {
      final snackBar = SnackBar(
        content: Text(response),
      );
      Timer(
        Duration(milliseconds: 500),
        () {
          Navigator.pop(context);
          setState(() {
            mostraDetalhes = false;
          });
        },
      );
      widget.scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  situacaoShowDialog(BuildContext context) async {
    // configura o  AlertDialog
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Container(
                child: Column(
                  children: <Widget>[
                    Text("Para qual situação você deseja alterar o ativo?"),
                    Visibility(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Loader(),
                      ),
                      visible: _sending,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.checkboxMarked),
                      tooltip: 'Define ativo para situação Regular (normal)',
                      onPressed: _sending
                          ? null
                          : () async {
                              await alterarSituacaoEAtualizaTela(
                                  setState, "Regular");
                            },
                    ),
                    Text('Regular'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.lightbulbOn),
                      tooltip: 'Define ativo para situação Oportunidade',
                      onPressed: _sending
                          ? null
                          : () async {
                              await alterarSituacaoEAtualizaTela(
                                  setState, "Oportunidade");
                            },
                    ),
                    Text('Oportunidade'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.virus),
                      tooltip: 'Define ativo para situação Quarentena',
                      onPressed: _sending
                          ? null
                          : () async {
                              await alterarSituacaoEAtualizaTela(
                                  setState, "Quarentena");
                            },
                    ),
                    Text('Quarentena'),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future alterarSituacaoEAtualizaTela(
      StateSetter setState, String situacao) async {
    setState(() {
      _sending = true;
    });
    await alterarSituacao(situacao);
    setState(() {
      _sending = false;
    });
  }
}
