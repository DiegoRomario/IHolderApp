class UsuarioViewModel {
  String nome;
  String email;
  String token;
  DateTime expiraEm;
  String id;

  UsuarioViewModel({this.nome, this.email, this.token, this.expiraEm, this.id});

  UsuarioViewModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    token = json['token'];
    expiraEm = DateTime.parse(json['expira_em']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['token'] = this.token;
    data['expira_em'] = this.expiraEm;
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return 'DEMOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO {login: $nome, password: $email}';
  }
}
