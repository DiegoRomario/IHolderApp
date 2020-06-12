class AtivoEmCarteira {
  String id;
  String ativoId;
  double precoMedio;
  double quantidade;
  DateTime dataPrimeiroAporte;

  AtivoEmCarteira(
      {this.ativoId,
      this.precoMedio,
      this.quantidade,
      this.dataPrimeiroAporte});

  ativoEmCarteirafromJson(Map<String, dynamic> json) {
    id = json['id'];
    ativoId = json['ativoId'];
    precoMedio = json['precoMedio'];
    quantidade = json['quantidade'];
    dataPrimeiroAporte = json['dataPrimeiroAporte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ativoId'] = this.ativoId;
    data['precoMedio'] = this.precoMedio;
    data['quantidade'] = this.quantidade;
    data['dataPrimeiroAporte'] = this.dataPrimeiroAporte.toString();
    return data;
  }
}
