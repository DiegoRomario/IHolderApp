import 'package:flutter/material.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo.screen.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                leading: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(widget.ativo.ticker),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('R\$ ${Parser.toStringCurrency(widget.ativo.cotacao)}'),
                    ),
                  ],
                ),
                title: Text(widget.ativo.produtoDescricao),
                subtitle: Text(
                    "${widget.ativo.descricao} - ${widget.ativo.caracteristicas}"),
                trailing: IconButton(
                  icon: Icon(MdiIcons.chevronDown),
                  onPressed: () {
                    setState(() {
                      mostraDetalhes = !mostraDetalhes;
                    });
                  },
                ),
                isThreeLine: true,
              ),
            ),
            Visibility(
              visible: mostraDetalhes,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "R\$ Médio",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              "30,22",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Ultimo aporte",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              "01/02/2020",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Situação",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              widget.ativo.situacao,
                              style: TextStyle(fontWeight: FontWeight.w500),
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
