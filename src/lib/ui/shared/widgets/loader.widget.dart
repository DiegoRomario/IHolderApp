import 'package:flutter/material.dart';

class   Loader extends StatelessWidget {
  final String message;
  const Loader({this.message = "Carregando"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
