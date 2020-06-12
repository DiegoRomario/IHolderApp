import 'package:flutter/material.dart';
import 'package:iholder_app/models/aporte-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-aporte.screen.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:intl/intl.dart';

class AporteCard extends StatefulWidget {
  final AporteViewModel aporte;
  final formatter = new DateFormat('dd/MM/yyyy');

  AporteCard(this.aporte);
  @override
  _AporteCardState createState() => _AporteCardState();
}

class _AporteCardState extends State<AporteCard> {
  bool mostraDetalhes = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) =>
                      CadastroAporteScreen(aporteViewModel: widget.aporte)),
            );
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${widget.aporte.ativoTicker} (${widget.aporte.produtoDescricao})"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "R\$ ${Parser.toStringCurrency(widget.aporte.precoMedio)} "),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "R\$ Médio",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  Parser.toStringCurrency(
                                      widget.aporte.precoMedio),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Quantidade",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  widget.aporte.quantidade.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "R\$ Aplicado",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  Parser.toStringCurrency(
                                      widget.aporte.valorAplicado),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "R\$ Total",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  widget.aporte.quantidade.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "R\$ Saldo",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  Parser.toStringCurrency(widget.aporte.saldo),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: widget.aporte.saldo > 0
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
