import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController pcontroller;
  final String plabel;
  final String phint;
  final int pMaxLength;
  final bool pObscureText;
  final IconData picon;
  final TextInputType ptype;
  final List<TextInputFormatter> pFormatters;
  final Function(String value) pValidador;
  final Function(String value) pOnSaved;

  const InputField(
      {this.pcontroller,
      this.plabel,
      this.phint,
      this.pMaxLength,
      this.pObscureText = false,
      this.picon,
      this.ptype,
      this.pFormatters,
      this.pValidador,
      this.pOnSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: TextFormField(
        maxLength: pMaxLength,
        obscureText: pObscureText,
        keyboardType: ptype,
        inputFormatters: pFormatters,
        controller: pcontroller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          icon: Icon(picon),
          hintText: phint,
          counterText: '',
          labelText: plabel,
        ),
        validator: pValidador,
        onSaved: pOnSaved,
      ),
    );
  }
}
