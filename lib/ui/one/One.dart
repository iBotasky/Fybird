import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/one/OneData.dart';
import 'package:intl/intl.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  List<Content> _datas = List();
  bool _isLoadComplete = false; //用以判断加载状态实现切换界面
  ScrollController _controller = ScrollController();
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("loadMore");
        _getOneDatas();
      }
    });

    _getOneDatas();
  }

  Future<void> _handleDatas() {
    return _getOneDatas();
  }

  List<String> _getLast7DaysDate() {
    final format = DateFormat('yyyy-MM-dd');
    List<String> dates = List<String>();
    for (int i = 0; i < 7; i++) {
      DateTime dateTime = DateTime(_now.year, _now.month, _now.day - i);
      print(format.format(dateTime));
      dates.add(format.format(dateTime));

      if (i == 6) {
        _now = DateTime(_now.year, _now.month, _now.day - 7);
      }
    }
    return dates;
  }

  Future<void> _getOneDatas() async {
    List<String> dates = _getLast7DaysDate();
    final _dio = Dio();
    List<Content> datas = List();
    for (String date in dates) {
      Response response =
          await _dio.get(URL_ONE_HOST + '/api/channel/one/$date/0');
      datas.add(OneData.fromJson(response.data).data.contentList[0]);
    }

    setState(() {
      _datas.addAll(datas);
      _isLoadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _isLoadComplete
          ? RefreshIndicator(
              onRefresh: _handleDatas,
              child: ListView.builder(
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  if (index != _datas.length) {
                    return OneDetailItem(
                      data: _datas[index],
                    );
                  } else {
                    return LoadMoreView();
                  }
                },
                itemCount: _datas.isEmpty ? 0 : _datas.length + 1,
              ))
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
            placeholder: ASSETS_IMAGE_HOLDER,
            image: data.imgUrl),
        Container(
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                // Colors are easy thanks to Flutter's
                // Colors class.
                Color.fromARGB(210, 0, 0, 0),
                Color.fromARGB(100, 0, 0, 0),
                Color.fromARGB(30, 0, 0, 0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
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
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
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
