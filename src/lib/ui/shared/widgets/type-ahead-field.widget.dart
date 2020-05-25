import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadField extends StatelessWidget {
  final TextEditingController pcontroller;
  final String plabel;
  final String phint;
  final IconData picon;
  final Function(String value) pValidador;
  final Function(String value) pOnSaved;
  final Function(String value) pGetSuggestions;

  TypeAheadField(
      {this.pcontroller,
      this.plabel,
      this.phint,
      this.picon,
      this.pValidador,
      this.pOnSaved,
      @required this.pGetSuggestions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: pcontroller,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            icon: Icon(picon),
            hintText: phint,
            labelText: plabel,
          ),
        ),
        suggestionsCallback: (pattern) {
          return pGetSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          pcontroller.text = suggestion;
        },
        validator: pValidador,
        onSaved: pOnSaved,
      ),
    );
  }
}
