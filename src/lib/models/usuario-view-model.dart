class UsuarioViewModel {
  String nome;
  String email;
  String token;
  String expiraEm;

  UsuarioViewModel({this.nome, this.email, this.token, this.expiraEm});

  UsuarioViewModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    token = json['token'];
    expiraEm = json['expira_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['token'] = this.token;
    data['expira_em'] = this.expiraEm;
    return data;
  }
}
