class DistribuicaoDivisao {
  bool somenteAtivosEmCarteira;

  DistribuicaoDivisao({this.somenteAtivosEmCarteira});

  DistribuicaoDivisao.fromJson(Map<String, dynamic> json) {
    somenteAtivosEmCarteira = json['somenteAtivosEmCarteira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['somenteAtivosEmCarteira'] = this.somenteAtivosEmCarteira;
    return data;
  }
}
