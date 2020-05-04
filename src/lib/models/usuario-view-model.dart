class UsuarioViewModel {
  String nome;
  String email;
  String senha;
  String cpf;
  String celular;
  DateTime dataNascimento;
  int genero;
  DateTime dataInclusao;
  DateTime dataAlteracao;
  String token;
  DateTime expiraEm;
  String id;

  UsuarioViewModel(
      {this.nome,
      this.email,
      this.senha,
      this.cpf,
      this.celular,
      this.dataNascimento,
      this.genero,
      this.dataInclusao,
      this.dataAlteracao,
      this.token,
      this.expiraEm,
      this.id});

  UsuarioViewModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    cpf = json['cpf'];
    celular = json['celular'];
    dataNascimento = json['data_nascimento'];
    genero = json['genero'];
    dataInclusao = json['data_inclusao'];
    dataAlteracao = json['data_alteracao'];
    token = json['token'];
    expiraEm = json['expira_em'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    data['celular'] = this.celular;
    data['data_nascimento'] = this.dataNascimento;
    data['genero'] = this.genero;
    data['data_inclusao'] = this.dataInclusao;
    data['data_alteracao'] = this.dataAlteracao;
    data['token'] = this.token;
    data['expira_em'] = this.expiraEm;
    data['id'] = this.id;
    return data;
  }
}
