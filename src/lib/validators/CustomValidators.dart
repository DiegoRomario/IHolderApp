class CustomValidators {
  static bool email(String value) {
    RegExp regex =
        new RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");

    if (value.isEmpty) {
      return false;
    }
    bool teste = regex.hasMatch(value);
    return teste;
  }

  static bool cpf(String value) {
    RegExp regex = new RegExp(r"^((\d{3}).(\d{3}).(\d{3})-(\d{2}))*$");

    if (value.isEmpty) {
      return false;
    }
    return regex.hasMatch(value);
  }
}
