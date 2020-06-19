import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:iholder_app/ui/android/screens/tab.screen.dart';

class SplashPage extends StatelessWidget {
  Future delay(context) async {
    await new Future.delayed(
        new Duration(
          milliseconds: 3500,
        ), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => TabsScreen(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 300,
              child: FlareActor(
                "assets/animations/demo.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                isPaused: false,
                animation: 'start',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
