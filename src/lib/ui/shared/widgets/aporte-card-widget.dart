import 'package:flutter/material.dart';
import 'package:iholder_app/models/Aporte-view-model.dart';
import 'package:iholder_app/ui/android/screens/cadastro-aporte.screen.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                builder: (ctx) => CadastroAporteScreen(),
              ),
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
                      Column(
                        children: <Widget>[
                          Text(
                            "01/01/2015",
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "R\$ Médio",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              "1500.20",
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
                              "150",
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "R\$ Total",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              "1500.55",
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
