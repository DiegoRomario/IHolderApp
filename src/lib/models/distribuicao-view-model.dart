class DistribuicaoViewModel {
  String id;
  String tipoDistribuicaoId;
  String descricao;
  String caracteristicas;
  double percentualObjetivo;
  double percentualAtual;
  double percentualDiferenca;
  double valorAtual;
  double valorDiferenca;
  String usuarioId;
  String orientacao;

  static List<DistribuicaoViewModel> obter() {
    return <DistribuicaoViewModel>[
      DistribuicaoViewModel(
          descricao: "Caixa",
          percentualObjetivo: 50,
          percentualAtual: 40,
          percentualDiferenca: 10,
          valorAtual: 5000,
          valorDiferenca: 1000,
          orientacao: "Buy"),
      DistribuicaoViewModel(
          descricao: "Fixa",
          percentualObjetivo: 25,
          percentualAtual: 30,
          percentualDiferenca: -5,
          valorAtual: 3000,
          valorDiferenca: -5000,
          orientacao: "Hold"),
      DistribuicaoViewModel(
          descricao: "Variável",
          percentualObjetivo: 25,
          percentualAtual: 20,
          percentualDiferenca: 5,
          valorAtual: 2000,
          valorDiferenca: 5000,
          orientacao: "Buy"),
    ];
  }

  DistribuicaoViewModel(
      {this.id,
      this.tipoDistribuicaoId,
      this.descricao,
      this.caracteristicas,
      this.percentualObjetivo,
      this.percentualAtual,
      this.percentualDiferenca,
      this.valorAtual,
      this.valorDiferenca,
      this.usuarioId,
      this.orientacao});

  DistribuicaoViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoDistribuicaoId = json['tipoDistribuicaoId'];
    descricao = json['descricao'];
    caracteristicas = json['caracteristicas'];
    percentualObjetivo = json['percentualObjetivo'];
    percentualAtual = json['percentualAtual'];
    percentualDiferenca = json['percentualDiferenca'];
    valorAtual = json['valorAtual'];
    valorDiferenca = json['valorDiferenca'];
    usuarioId = json['usuarioId'];
    orientacao = json['orientacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipoDistribuicaoId'] = this.tipoDistribuicaoId;
    data['descricao'] = this.descricao;
    data['caracteristicas'] = this.caracteristicas;
    data['percentualObjetivo'] = this.percentualObjetivo;
    data['percentualAtual'] = this.percentualAtual;
    data['percentualDiferenca'] = this.percentualDiferenca;
    data['valorAtual'] = this.valorAtual;
    data['valorDiferenca'] = this.valorDiferenca;
    data['usuarioId'] = this.usuarioId;
    data['orientacao'] = this.orientacao;
    return data;
  }
}
