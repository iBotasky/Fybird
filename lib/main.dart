import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/Home.dart';
import 'package:flutter_cybird/ui/SplashScreen.dart';

void main() => runApp(MaterialApp(
      title: 'Fybird',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primaryColor: Colors.blue[800]),
      home: SplashScreen(),
      routes: {
        HOME_SCREEN: (BuildContext context) => HomePage(),
        ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
      },
    ));

