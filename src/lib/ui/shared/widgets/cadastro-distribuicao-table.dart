import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CadastroDistribuicaoTable extends StatefulWidget {
  final List<DistribuicaoViewModel> distribuicoes;

  const CadastroDistribuicaoTable({@required this.distribuicoes});
  @override
  _CadastroDistribuicaoTableState createState() =>
      _CadastroDistribuicaoTableState();
}

class _CadastroDistribuicaoTableState extends State<CadastroDistribuicaoTable> {
  List<DistribuicaoViewModel> distribuicoesSelecionadas;
  bool sort;

  @override
  void initState() {
    sort = false;
    distribuicoesSelecionadas = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              //columnSpacing: MediaQuery.of(context).size.width / 4,
              sortAscending: sort,
              sortColumnIndex: 0,
              columns: [
                DataColumn(
                  label: Icon(MdiIcons.wallet),
                ),
                DataColumn(
                  label: Text(
                    'Ticker',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '% Objetivo',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                  ),
                ),
                DataColumn(
                  label: Text(''),
                ),
              ],
              rows: widget.distribuicoes
                  .map(
                    (item) => DataRow(
                      selected: distribuicoesSelecionadas.contains(item),
                      cells: [
                        DataCell(
                          Text("Sim"),
                        ),
                        DataCell(
                          Text(item.descricao),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                PercentInputFormatter(maxDigits: 5)
                              ],
                              initialValue: Parser.toStringCurrency(
                                  item.percentualObjetivo),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (Parser.toDoubleCurrency(value) > 100) {
                                  return '% Inválido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.save,
                                color: Theme.of(context).primaryColorLight),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Icon(MdiIcons.divisionBox),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Entre ativos em carteira'),
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
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Icon(MdiIcons.divisionBox),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Entre ativos cadastrados'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
