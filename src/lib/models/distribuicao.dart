import 'package:flutter/cupertino.dart';

class Distribuicao {
  String id;
  String tipoDistribuicaoId;
  double percentualObjetivo;

  Distribuicao({
    @required this.id,
    @required this.tipoDistribuicaoId,
    @required this.percentualObjetivo,
  });

  Distribuicao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoDistribuicaoId = json['tipoDistribuicaoId'];
    percentualObjetivo = json['percentualObjetivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipoDistribuicaoId'] = this.tipoDistribuicaoId;
    data['percentualObjetivo'] = this.percentualObjetivo;
    return data;
  }
}
