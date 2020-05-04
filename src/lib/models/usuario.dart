class Usuario {
  String nome;
  String email;
  String senha;
  String cpf;
  String celular;
  DateTime data_nascimento;
  int genero;

  Usuario(
      {this.nome,
      this.email,
      this.senha,
      this.cpf,
      this.celular,
      this.data_nascimento,
      this.genero});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    cpf = json['cpf'];
    celular = json['celular'];
    data_nascimento = json['data_nascimento'];
    genero = json['genero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    data['celular'] = this.celular;
    data['data_nascimento'] = this.data_nascimento;
    data['genero'] = this.genero;
    return data;
  }
}
