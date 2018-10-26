import 'package:flutter/material.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  String _string = 'Test';

  @override
  void initState() {
    print("initState");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('One is all'),
    ));
  }
}
