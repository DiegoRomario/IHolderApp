class Ativo {
  String id;
  String produtoId;
  String descricao;
  String caracteristicas;
  String ticker;
  double cotacao;
  String usuarioId;
  DateTime dataReferenciaSituacao;
  String situacao;

  Ativo(
      {this.produtoId,
      this.descricao,
      this.caracteristicas,
      this.ticker,
      this.cotacao,
      this.usuarioId,
      this.dataReferenciaSituacao,
      this.situacao});

  Ativo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    descricao = json['descricao'];
    caracteristicas = json['caracteristicas'];
    ticker = json['ticker'];
    cotacao = json['cotacao'];
    usuarioId = json['usuarioId'];
    dataReferenciaSituacao = json['dataReferenciaSituacao'];
    situacao = json['situacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['descricao'] = this.descricao;
    data['caracteristicas'] = this.caracteristicas;
    data['ticker'] = this.ticker;
    data['cotacao'] = this.cotacao;
    data['usuarioId'] = this.usuarioId;
    data['dataReferenciaSituacao'] = this.dataReferenciaSituacao.toString();
    data['situacao'] = this.situacao;
    return data;
  }
}
