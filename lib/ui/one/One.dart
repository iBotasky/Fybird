import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cybird/ui/one/OneDatas.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  void initState() {
    super.initState();
    print('initState');
    _getOneDatas('2018-10-25');
  }


  _getOneDatas(String date) async {
    Dio dio = Dio();
    Response response = await dio.get(URL_ONE_HOST + '/api/channel/one/$date/0');

    Map userMap = json.decode(response.data.toString());
    var data = new OneDetail.fromJson(userMap);
    final String url = data.data.contentList[0].imgUrl;
    print("image url $url");
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
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                // Colors are easy thanks to Flutter's
                // Colors class.
                Color.fromARGB(200, 0, 0, 0),
                Color.fromARGB(100, 0, 0, 0),
                Color.fromARGB(50, 0, 0, 0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
//              stops: [0.1, 0.5, 0.9],
            ))),

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
