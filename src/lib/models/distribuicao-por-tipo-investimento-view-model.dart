class DistribuicaoPorTipoInvestimentoViewModel {
  String id;
  String tipoInvestimentoId;
  String descricaoTipoInvestimento;
  String caracteristicasTipoInvestimento;
  double percentualObjetivo;
  double percentualAtual;
  double percentualDiferenca;
  double valorAtual;
  double valorDiferenca;
  String usuarioId;
  String orientacao;

  static List<DistribuicaoPorTipoInvestimentoViewModel> obter() {
    return <DistribuicaoPorTipoInvestimentoViewModel>[
      DistribuicaoPorTipoInvestimentoViewModel(
          descricaoTipoInvestimento: "Caixa",
          percentualObjetivo: 50,
          percentualAtual: 40,
          percentualDiferenca: 10,
          valorAtual: 5000,
          valorDiferenca: 1000,
          orientacao: "Buy"),
      DistribuicaoPorTipoInvestimentoViewModel(
          descricaoTipoInvestimento: "Fixa",
          percentualObjetivo: 25,
          percentualAtual: 30,
          percentualDiferenca: -5,
          valorAtual: 3000,
          valorDiferenca: -5000,
          orientacao: "Hold"),
      DistribuicaoPorTipoInvestimentoViewModel(
          descricaoTipoInvestimento: "Variável",
          percentualObjetivo: 25,
          percentualAtual: 20,
          percentualDiferenca: 5,
          valorAtual: 2000,
          valorDiferenca: 5000,
          orientacao: "Buy"),
    ];
  }

  DistribuicaoPorTipoInvestimentoViewModel(
      {this.id,
      this.tipoInvestimentoId,
      this.descricaoTipoInvestimento,
      this.caracteristicasTipoInvestimento,
      this.percentualObjetivo,
      this.percentualAtual,
      this.percentualDiferenca,
      this.valorAtual,
      this.valorDiferenca,
      this.usuarioId,
      this.orientacao});

  DistribuicaoPorTipoInvestimentoViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoInvestimentoId = json['tipoInvestimentoId'];
    descricaoTipoInvestimento = json['descricaoTipoInvestimento'];
    caracteristicasTipoInvestimento = json['caracteristicasTipoInvestimento'];
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
    data['tipoInvestimentoId'] = this.tipoInvestimentoId;
    data['descricaoTipoInvestimento'] = this.descricaoTipoInvestimento;
    data['caracteristicasTipoInvestimento'] =
        this.caracteristicasTipoInvestimento;
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
