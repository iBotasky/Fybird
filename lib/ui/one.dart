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
      body: Container(
        child: RaisedButton(
            child: Text(_string),
            onPressed: () {
              setState(() {
                _string = _string + "1";
              });
            }),
      ),
    );
  }
}
