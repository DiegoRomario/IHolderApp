class Ativo {
  String produtoId;
  String descricao;
  String caracteristicas;
  String ticker;
  double cotacao;
  String usuarioId;

  Ativo(
      {this.produtoId,
      this.descricao,
      this.caracteristicas,
      this.ticker,
      this.cotacao,
      this.usuarioId});

  Ativo.fromJson(Map<String, dynamic> json) {
    produtoId = json['produtoId'];
    descricao = json['descricao'];
    caracteristicas = json['caracteristicas'];
    ticker = json['ticker'];
    cotacao = json['cotacao'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produtoId'] = this.produtoId;
    data['descricao'] = this.descricao;
    data['caracteristicas'] = this.caracteristicas;
    data['ticker'] = this.ticker;
    data['cotacao'] = this.cotacao;
    data['usuarioId'] = this.usuarioId;
    return data;
  }
}
