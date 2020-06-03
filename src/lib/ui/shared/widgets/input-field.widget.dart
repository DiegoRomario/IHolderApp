import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController pcontroller;
  final String plabel;
  final String phint;
  final int pMaxLength;
  final bool pObscureText;
  final bool pEnabled;
  final IconData picon;
  final TextInputType ptype;
  final IconData pSuffixIcon;
  final List<TextInputFormatter> pFormatters;
  final Function(String value) pValidador;
  final Function(String value) pOnSaved;
  final Function(String value) pOnChange;
  final Future<dynamic> Function() pOnSuffixIcon;

  const InputField(
      {this.pcontroller,
      this.plabel,
      this.phint,
      this.pMaxLength,
      this.pObscureText = false,
      this.picon,
      this.ptype,
      this.pEnabled = true,
      this.pFormatters,
      this.pValidador,
      this.pSuffixIcon,
      this.pOnSuffixIcon,
      this.pOnChange,
      this.pOnSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextFormField(
            enabled: pEnabled,
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
            onChanged: pOnChange,
          ),
          Visibility(
            visible: pSuffixIcon != null,
            child: Container(
              width: 65,
              child: FlatButton(
                onPressed: pOnSuffixIcon,
                child: Icon(pSuffixIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}
