import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController pcontroller;
  final String plabel;
  final String phint;
  final bool pObscureText;
  final IconData picon;
  final TextInputType ptype;
  final Function(String value) pValidador;
  final Function(String value) pOnSaved;

  const InputField(
      {this.pcontroller,
      this.plabel,
      this.phint,
      this.pObscureText = false,
      this.picon,
      this.ptype,
      this.pValidador,
      this.pOnSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: TextFormField(
        obscureText: pObscureText,
        keyboardType: ptype,
        controller: pcontroller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          icon: Icon(picon),
          hintText: phint,
          labelText: plabel,
        ),
        validator: pValidador,
        onSaved: pOnSaved,
      ),
    );
  }
}
