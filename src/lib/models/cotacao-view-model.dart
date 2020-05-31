class CotacaoViewModel {
  String ticker;
  double abertura;
  double maxima;
  double minima;
  double preco;
  double volume;
  String ultimoDataNegociacao;
  double fechamentoAnterior;
  double variacao;
  double variacaoPercentual;

  CotacaoViewModel(
      {this.ticker,
      this.abertura,
      this.maxima,
      this.minima,
      this.preco,
      this.volume,
      this.ultimoDataNegociacao,
      this.fechamentoAnterior,
      this.variacao,
      this.variacaoPercentual});

  CotacaoViewModel.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    abertura = json['abertura'];
    maxima = json['maxima'];
    minima = json['minima'];
    preco = json['preco'];
    volume = json['volume'];
    ultimoDataNegociacao = json['ultimoDataNegociacao'];
    fechamentoAnterior = json['fechamentoAnterior'];
    variacao = json['variacao'];
    variacaoPercentual = json['variacaoPercentual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this.ticker;
    data['abertura'] = this.abertura;
    data['maxima'] = this.maxima;
    data['minima'] = this.minima;
    data['preco'] = this.preco;
    data['volume'] = this.volume;
    data['ultimoDataNegociacao'] = this.ultimoDataNegociacao;
    data['fechamentoAnterior'] = this.fechamentoAnterior;
    data['variacao'] = this.variacao;
    data['variacaoPercentual'] = this.variacaoPercentual;
    return data;
  }
}
