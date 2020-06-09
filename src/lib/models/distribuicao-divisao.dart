class DistribuicaoDivisao {
  bool somenteItensEmCarteira;

  DistribuicaoDivisao({this.somenteItensEmCarteira});

  DistribuicaoDivisao.fromJson(Map<String, dynamic> json) {
    somenteItensEmCarteira = json['somenteItensEmCarteira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['somenteItensEmCarteira'] = this.somenteItensEmCarteira;
    return data;
  }
}
