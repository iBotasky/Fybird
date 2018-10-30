import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/one/OneData.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  List<Content> datas = List();
  bool isLoadComplete = false; //用以判断加载状态实现切换界面

  @override
  void initState() {
    super.initState();
    getOneDatas().then((value) {
      setState(() {
        datas = value;
        isLoadComplete = true;
      });
    });
  }

  List<String> _getLast7DaysDate() {
    DateTime now = DateTime.now();
    final format = DateFormat('yyyy-MM-dd');
    List<String> dates = List<String>();
    for (int i = 0; i < 7; i++) {
      DateTime dateTime = DateTime(now.year, now.month, now.day - i);
      print(format.format(dateTime));
      dates.add(format.format(dateTime));
    }
    return dates;
  }

  Future<List<Content>> getOneDatas() async {
    List<String> dates = _getLast7DaysDate();
    final client = http.Client();
    List<Content> datas = List();
    for (String date in dates) {
      http.Response response =
          await client.get(URL_ONE_HOST + '/api/channel/one/$date/0');
      Map oneData = json.decode(response.body);
      datas.add(OneData.fromJson(oneData).data.contentList[0]);
    }
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: isLoadComplete
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return OneDetailItem(
                  data: datas[index],
                );
              },
              itemCount: datas.isEmpty ? 0 : datas.length,
            )
          : LoadingView(),
    ));
  }
}

class OneDetailItem extends StatefulWidget {
  final Content data;

  const OneDetailItem({Key key, this.data}) : super(key: key);

  @override
  _OneDetailItemState createState() => _OneDetailItemState(data);
}

class _OneDetailItemState extends State<OneDetailItem> {
  final Content data;
  final TextStyle _bottom =
      TextStyle(color: Colors.white, fontStyle: FontStyle.italic);

  _OneDetailItemState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        FadeInImage.assetNetwork(
            width: double.infinity,
            fit: BoxFit.cover,
            height: 240.0,
            placeholder: 'assets/images/ic_launcher_foreground.png',
            image: data.imgUrl),
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
            width: double.infinity,
            height: 240.0,
            child: Container(
                margin: EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.volume,
                      style: TextStyle(
//                          color: Color.fromARGB(255, 33, 33, 33),
                      color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(data.forward,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal)))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('摄影|${data.picInfo}', style: _bottom),
                        Text(data.wordsInfo, style: _bottom)
                      ],
                    )
                  ],
                ))),
      ],
    ));
  }
}
