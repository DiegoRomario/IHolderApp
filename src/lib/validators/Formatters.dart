import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = formatter.format(value / 100);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class Parser {
  static double toDoubleCurrency(String number) {
    number = number.replaceAll(".", "");
    number = number.replaceAll(",", ".");
    var aux = double.tryParse(number) ?? 0;
    return aux;
  }

  static String toStringCurrency(double number) {
    NumberFormat oCcy = new NumberFormat("#,##0.00", "pt_BR");
    String formatted = oCcy.format(number);
    return formatted;
  }

}
