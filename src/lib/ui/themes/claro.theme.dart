import 'package:flutter/material.dart';

ThemeData claroTheme() {
  return ThemeData(
    // primarySwatch: primaryColor,
    brightness: Brightness.light,
    // textTheme: new TextTheme(
    //   body1: new TextStyle(color: Colors.red),
    //   display4: new TextStyle(fontSize: 78),
    //   button: new TextStyle(color: Colors.green),
    //   headline: new TextStyle(color: Colors.deepPurple)
    // ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.indigo[800],
      unselectedLabelColor: Colors.black38,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Colors.red[300]),
        insets: EdgeInsets.zero,
      ),
    ),
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    // bottomAppBarTheme:
    buttonTheme: new ButtonThemeData(
      buttonColor: Colors.indigo[800],
      textTheme: ButtonTextTheme.accent,
    ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    // iconTheme:
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    primaryColor: Colors.indigo[600],
    accentColor: Colors.red[300],
    fontFamily: 'RobotoCondensed',
    // buttonColor: Color(0xFF00C569),
    //scaffoldBackgroundColor: Colors.blue[50],
    cardColor: Colors.grey[200],
  );
}
