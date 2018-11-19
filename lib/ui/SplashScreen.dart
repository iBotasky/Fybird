import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  void navigationHome() {
    Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
  }

  startTime() async {
    return Timer(Duration(seconds: 3), navigationHome);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                    'Cybird Flutter',
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 30.0, fontStyle: FontStyle.italic),
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Image.asset('assets/images/logo.png',
                    height: 25.0, fit: BoxFit.scaleDown),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/ic_launcher_foreground.png',
                  height: animation.value * 200, width: animation.value * 200)
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animation = null;
    animationController = null;
    super.dispose();
  }
}
