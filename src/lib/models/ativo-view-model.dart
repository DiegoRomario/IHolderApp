class AtivoViewModel {
  String id;
  String produtoId;
  String produtoDescricao;
  String tipoDescricao;
  String descricao;
  String caracteristicas;
  String ticker;
  double cotacao;
  String situacao;
  String usuarioId;
  DateTime dataReferenciaSituacao;

  AtivoViewModel(
      {this.id,
      this.produtoId,
      this.produtoDescricao,
      this.tipoDescricao,
      this.descricao,
      this.caracteristicas,
      this.ticker,
      this.cotacao,
      this.situacao,
      this.usuarioId,
      this.dataReferenciaSituacao});

  AtivoViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    produtoDescricao = json['produtoDescricao'];
    tipoDescricao = json['tipoDescricao'];
    descricao = json['descricao'];
    caracteristicas = json['caracteristicas'];
    ticker = json['ticker'];
    cotacao = json['cotacao'];
    situacao = json['situacao'];
    usuarioId = json['usuarioId'];
    dataReferenciaSituacao =
        DateTime.parse(json['dataReferenciaSituacao'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['produtoDescricao'] = this.produtoDescricao;
    data['tipoDescricao'] = this.tipoDescricao;
    data['descricao'] = this.descricao;
    data['caracteristicas'] = this.caracteristicas;
    data['ticker'] = this.ticker;
    data['cotacao'] = this.cotacao;
    data['situacao'] = this.situacao;
    data['usuarioId'] = this.usuarioId;
    data['dataReferenciaSituacao'] = this.dataReferenciaSituacao.toString();
    return data;
  }
}
