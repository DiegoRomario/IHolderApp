import 'package:flutter/material.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-ativo-em-carteira.screen.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:intl/intl.dart';

class AtivoEmCarteiraCard extends StatefulWidget {
  final AtivoEmCarteiraViewModel ativoEmCarteira;
  final formatter = new DateFormat('dd/MM/yyyy');

  AtivoEmCarteiraCard(this.ativoEmCarteira);
  @override
  _AtivoEmCarteiraCardState createState() => _AtivoEmCarteiraCardState();
}

class _AtivoEmCarteiraCardState extends State<AtivoEmCarteiraCard> {
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
                  builder: (ctx) => CadastroAtivoEmCarteiraScreen(
                      ativoEmCarteiraViewModel: widget.ativoEmCarteira)),
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
                            "${widget.ativoEmCarteira.ativoTicker} (${widget.ativoEmCarteira.produtoDescricao})"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "R\$ ${Parser.toStringCurrency(widget.ativoEmCarteira.precoMedio)} "),
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
                                      widget.ativoEmCarteira.precoMedio),
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
                                  widget.ativoEmCarteira.quantidade.toString(),
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
                                      widget.ativoEmCarteira.valorAplicado),
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
                                  widget.ativoEmCarteira.quantidade.toString(),
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
                                  Parser.toStringCurrency(
                                      widget.ativoEmCarteira.saldo),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: widget.ativoEmCarteira.saldo > 0
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
