import 'package:flutter/material.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DistribuicoesTable extends StatefulWidget {
  @override
  _DistribuicoesTableState createState() => _DistribuicoesTableState();
}

class _DistribuicoesTableState extends State<DistribuicoesTable> {
  List<DistribuicaoPorTipoInvestimentoViewModel> distribuicoes;
  List<DistribuicaoPorTipoInvestimentoViewModel> distribuicoesSelecionadas;
  bool sort;

  @override
  void initState() {
    sort = false;
    distribuicoesSelecionadas = [];
    distribuicoes = DistribuicaoPorTipoInvestimentoViewModel.obter();
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        distribuicoes.sort((a, b) => a.orientacao.compareTo(b.orientacao));
      } else {
        distribuicoes.sort((a, b) => b.orientacao.compareTo(a.orientacao));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Distribuição por tipo de investimento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                'Tipo',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
            DataColumn(
              label: Text(
                '% Obj.',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
            DataColumn(
              label: Text(
                '% Atual',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
            DataColumn(
              label: Text(
                '% Dif.',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
            DataColumn(
              label: Text(
                'R\$ Atual',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
            DataColumn(
              label: Text(
                'R\$ Dif.',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.00),
              ),
            ),
          ],
          rows: distribuicoes
              .map(
                (item) => DataRow(
                  selected: distribuicoesSelecionadas.contains(item),
                  cells: [
                    DataCell(
                      Text(
                        item.orientacao,
                        style: TextStyle(
                            color: item.orientacao == "Buy"
                                ? Colors.green
                                : Colors.orangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Text(item.descricaoTipoInvestimento),
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
    );
  }
}
