class Usuario {
  String nome;
  String email;
  String senha;
  int genero;

  Usuario({this.nome, this.email, this.senha, this.genero});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    genero = json['genero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['genero'] = this.genero;
    return data;
  }
}
