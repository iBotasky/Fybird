import 'package:flutter/material.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return OneDetailItem();
        },
        itemCount: 20,
      ),
    ));
  }
}

class OneDetailItem extends StatefulWidget {
  @override
  _OneDetailItemState createState() => _OneDetailItemState();
}

class _OneDetailItemState extends State<OneDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
//        Image.network(
//          'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
//          fit: BoxFit.cover,
//          height: 240.0,
//          width: double.infinity,
//        ),
        FadeInImage.assetNetwork(
            width: double.infinity,
            fit: BoxFit.cover,
            height: 240.0,
            placeholder: 'assets/images/ic_launcher_foreground.png',
            image:
                'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true'),
        Container(
            margin: EdgeInsets.all(20),
            child: Text(
                'SizedBox.expand will make the button take full width and height, which is not the question about. The question is about a button covering full width only not height',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue[800],
                    fontStyle: FontStyle.normal))),
      ],
    ));
  }
}
