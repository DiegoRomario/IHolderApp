class Aporte {
  String id;
  String ativoId;
  double precoMedio;
  double quantidade;
  DateTime dataAporte;

  Aporte({this.ativoId, this.precoMedio, this.quantidade, this.dataAporte});

  Aporte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ativoId = json['ativoId'];
    precoMedio = json['precoMedio'];
    quantidade = json['quantidade'];
    dataAporte = json['dataAporte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ativoId'] = this.ativoId;
    data['precoMedio'] = this.precoMedio;
    data['quantidade'] = this.quantidade;
    data['dataAporte'] = this.dataAporte.toString();
    return data;
  }
}
