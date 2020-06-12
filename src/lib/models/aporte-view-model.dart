class AporteViewModel {
  String id;
  String ativoId;
  String ativoTicker;
  String ativoDescricao;
  String produtoDescricao;
  double precoMedio;
  double quantidade;
  double valorAplicado;
  double valorAtual;
  double saldo;
  DateTime dataPrimeiroAporte;

  AporteViewModel(
      {this.id,
      this.ativoId,
      this.ativoTicker,
      this.ativoDescricao,
      this.produtoDescricao,
      this.precoMedio,
      this.quantidade,
      this.valorAplicado,
      this.valorAtual,
      this.saldo,
      this.dataPrimeiroAporte});

  AporteViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ativoId = json['ativoId'];
    ativoTicker = json['ativoTicker'];
    ativoDescricao = json['ativoDescricao'];
    produtoDescricao = json['produtoDescricao'];
    precoMedio = json['precoMedio'];
    quantidade = json['quantidade'];
    valorAplicado = json['valorAplicado'];
    valorAtual = json['valorAtual'];
    saldo = json['saldo'];
    dataPrimeiroAporte = DateTime.parse(json['dataPrimeiroAporte'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ativoId'] = this.ativoId;
    data['ativoTicker'] = this.ativoTicker;
    data['ativoDescricao'] = this.ativoDescricao;
    data['produtoDescricao'] = this.produtoDescricao;
    data['precoMedio'] = this.precoMedio;
    data['quantidade'] = this.quantidade;
    data['valorAplicado'] = this.valorAplicado;
    data['valorAtual'] = this.valorAtual;
    data['saldo'] = this.saldo;
    data['dataPrimeiroAporte'] = this.dataPrimeiroAporte;
    return data;
  }
}
