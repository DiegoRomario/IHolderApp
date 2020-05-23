import 'package:flutter/material.dart';

ThemeData escuroTheme() {
  return ThemeData(
    // primarySwatch: primaryColor,

    brightness: Brightness.dark,
    // textTheme: new TextTheme(
    //   body1: new TextStyle(color: Colors.red),
    //   display4: new TextStyle(fontSize: 78),
    //   button: new TextStyle(color: Colors.green),
    //   headline: new TextStyle(color: Colors.deepPurple)
    // ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.red[300],
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Colors.indigo[300]),
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
    iconTheme: IconThemeData(color: Colors.white),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    primaryColor: Colors.indigo[600],
    accentColor: Colors.red[300],
    fontFamily: 'RobotoCondensed',
    scaffoldBackgroundColor: Colors.grey[900],
    // buttonColor: Color(0xFF00C569),
    // cardColor: Colors.white,
  );
}
