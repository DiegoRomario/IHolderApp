import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:iholder_app/ui/android/screens/tab.screen.dart';

class SplashPage extends StatelessWidget {
  Future delay(context) async {
    await new Future.delayed(
        new Duration(
          milliseconds: 3000,
        ), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => TabsScreen(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 750),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: Container(
            width: double.infinity,
            height: 300,
            child: FlareActor(
              "assets/animations/iholder.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              isPaused: false,
              animation: 'start',
            ),
          ),
        ),
      ),
    );
  }
}
