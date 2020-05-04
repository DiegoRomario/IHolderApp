class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}

class ExceptionConfiguration {
  static String getMessage(int status) {
    if (_statusCodeResponses.containsKey(status)) {
      return _statusCodeResponses[status];
    }
    return "Erro desconhecido";
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Requisição inválida',
    401: 'Falha de autenticação',
    409: 'Ocorreu um conflito no servidor',
    500: 'Erro interno no servidor'
  };
}
