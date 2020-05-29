class AporteViewModel {
  String id;
  String ativoId;
  String ativoTicker;
  String ativoDescricao;
  String produtoId;
  String produtoDescricao;
  double precoMedio;
  double quantidade;
  double precoTotal;
  DateTime dataAporte;

  AporteViewModel(
      {this.id,
      this.ativoId,
      this.ativoTicker,
      this.ativoDescricao,
      this.produtoId,
      this.produtoDescricao,
      this.precoMedio,
      this.quantidade,
      this.precoTotal,
      this.dataAporte});

  AporteViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ativoId = json['ativoId'];
    ativoTicker = json['ativoTicker'];
    ativoDescricao = json['ativoDescricao'];
    produtoId = json['produtoId'];
    produtoDescricao = json['produtoDescricao'];
    precoMedio = json['precoMedio'];
    quantidade = json['quantidade'];
    precoTotal = json['precoTotal'];
    dataAporte = DateTime.parse(json['dataAporte'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ativoId'] = this.ativoId;
    data['ativoTicker'] = this.ativoTicker;
    data['ativoDescricao'] = this.ativoDescricao;
    data['produtoId'] = this.produtoId;
    data['produtoDescricao'] = this.produtoDescricao;
    data['precoMedio'] = this.precoMedio;
    data['quantidade'] = this.quantidade;
    data['precoTotal'] = this.precoTotal;
    data['dataAporte'] = this.dataAporte;
    return data;
  }
}
