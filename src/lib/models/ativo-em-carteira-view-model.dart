class AtivoEmCarteiraViewModel {
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
  double percentual;
  DateTime dataPrimeiroAporte;
  double ultimaCotacao;
  double ultimaVariacao;
  double ultimaVariacaoPercentual;

  AtivoEmCarteiraViewModel(
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
      this.percentual,
      this.dataPrimeiroAporte,
      this.ultimaCotacao,
      this.ultimaVariacao,
      this.ultimaVariacaoPercentual});

  AtivoEmCarteiraViewModel.fromJson(Map<String, dynamic> json) {
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
    percentual = json['percentual'];
    dataPrimeiroAporte = DateTime.parse(json['dataPrimeiroAporte'].toString());
    ultimaCotacao = json['ultimaCotacao'];
    ultimaVariacao = json['ultimaVariacao'];
    ultimaVariacaoPercentual = json['ultimaVariacaoPercentual'];
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
    data['percentual'] = this.percentual;
    data['dataPrimeiroAporte'] = this.dataPrimeiroAporte;
    data['ultimaCotacao'] = this.ultimaCotacao;
    data['ultimaVariacao'] = this.ultimaVariacao;
    data['ultimaVariacaoPercentual'] = this.ultimaVariacaoPercentual;
    return data;
  }
}
