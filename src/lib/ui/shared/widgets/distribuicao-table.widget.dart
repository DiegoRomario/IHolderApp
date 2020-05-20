import 'package:flutter/material.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DistribuicaoTable extends StatefulWidget {
  final List<DistribuicaoViewModel> distribuicoes;

  const DistribuicaoTable({@required this.distribuicoes});
  @override
  _DistribuicaoTableState createState() => _DistribuicaoTableState();
}

class _DistribuicaoTableState extends State<DistribuicaoTable> {
  List<DistribuicaoViewModel> distribuicoesSelecionadas;
  bool sort;

  @override
  void initState() {
    sort = false;
    distribuicoesSelecionadas = [];
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        widget.distribuicoes
            .sort((a, b) => a.orientacao.compareTo(b.orientacao));
      } else {
        widget.distribuicoes
            .sort((a, b) => b.orientacao.compareTo(a.orientacao));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortAscending: sort,
            sortColumnIndex: 0,
            columns: [
              DataColumn(
                label: Icon(MdiIcons.signDirection),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColum(columnIndex, ascending);
                },
              ),
              DataColumn(
                label: Text(
                  'Descrição',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
              DataColumn(
                label: Text(
                  '% Obj.',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
              DataColumn(
                label: Text(
                  '% Atual',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
              DataColumn(
                label: Text(
                  '% Dif.',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
              DataColumn(
                label: Text(
                  'R\$ Atual',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
              DataColumn(
                label: Text(
                  'R\$ Dif.',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
                ),
              ),
            ],
            rows: widget.distribuicoes
                .map(
                  (item) => DataRow(
                    selected: distribuicoesSelecionadas.contains(item),
                    cells: [
                      DataCell(
                        Text(
                          item.orientacao,
                          style: TextStyle(
                              color: corPorOrientacao(item.orientacao),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text(item.descricao),
                      ),
                      DataCell(
                        Text(item.percentualObjetivo.toString()),
                      ),
                      DataCell(
                        Text(item.percentualAtual.toString()),
                      ),
                      DataCell(
                        Text(item.percentualDiferenca.toString()),
                      ),
                      DataCell(
                        Text(
                          item.valorAtual.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.valorDiferenca.toString(),
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  ColorSwatch<int> corPorOrientacao(String orientacao) {
    switch (orientacao) {
      case "Buy":
        return Colors.green;
        break;
      case "Hold":
        return Colors.blueAccent;
        break;
      default:
        return Colors.redAccent;
    }
  }
}
