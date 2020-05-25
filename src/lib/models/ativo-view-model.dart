class AtivoViewModel {
  String id;
  String produtoId;
  String produtoDescricao;
  String descricao;
  String caracteristicas;
  String ticker;
  double cotacao;
  String usuarioId;

  AtivoViewModel(
      {this.id,
      this.produtoId,
      this.produtoDescricao,
      this.descricao,
      this.caracteristicas,
      this.ticker,
      this.cotacao,
      this.usuarioId});

  AtivoViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    produtoDescricao = json['produtoDescricao'];
    descricao = json['descricao'];
    caracteristicas = json['caracteristicas'];
    ticker = json['ticker'];
    cotacao = json['cotacao'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['produtoDescricao'] = this.produtoDescricao;
    data['descricao'] = this.descricao;
    data['caracteristicas'] = this.caracteristicas;
    data['ticker'] = this.ticker;
    data['cotacao'] = this.cotacao;
    data['usuarioId'] = this.usuarioId;
    return data;
  }
}
