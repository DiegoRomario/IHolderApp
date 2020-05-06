import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InputFieldDate extends StatefulWidget {
  final TextEditingController pcontroller = new TextEditingController();
  final String plabel;
  final Function(String value) pValidador;
  final Function(String value) pOnSaved;
  InputFieldDate({this.plabel, this.pValidador, this.pOnSaved});
  final f = new DateFormat('dd/MM/yyyy');
  @override
  _InputFieldDateState createState() => _InputFieldDateState();
}

class _InputFieldDateState extends State<InputFieldDate> {
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: TextFormField(
        controller: widget.pcontroller,
        keyboardType: TextInputType.datetime,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          icon: Icon(MdiIcons.calendar),
          labelText: widget.plabel,
        ),
        validator: widget.pValidador,
        onSaved: widget.pOnSaved,
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2021))
              .then((date) {
            setState(() {
              _dateTime = date;
            });
          }).whenComplete(() {
            widget.pcontroller.text = widget.f.format(_dateTime);
          });
        },
      ),
    );
  }
}
