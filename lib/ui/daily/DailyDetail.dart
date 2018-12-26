import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/daily/data/DailyDetailData.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DailyDetail extends StatefulWidget {
  final String title;
  final String id;

  const DailyDetail({Key key, this.title, this.id}) : super(key: key);

  @override
  _DailyDetailState createState() => _DailyDetailState();
}

class _DailyDetailState extends State<DailyDetail> {
  Dio _dio;
  DailyDetailData _dailyData;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String _url = "";

  @override
  void initState() {
    super.initState();
    _dio = Dio(Options(
      connectTimeout: 10000,
      receiveTimeout: 3000,
      baseUrl: URL_ZHIHU_HOST,
    ));
    //获取数据
    _getDailyDeail();
  }

  Future<void> _getDailyDeail() async {
    String s = ''' hello"''';
    Response response = await _dio.get("${widget.id}");
    _dailyData = DailyDetailData.fromJson(response.data);
    String css =
        '''<link rel="stylesheet" href="${_dailyData.css[0]}" type="text/css">''';
    String html =
        '''<html><head>$css</head><body>${_dailyData.body}</body></html>''';
    html.replaceAll('''<div class="img-place-holder">''', "");
    setState(() {
      _url = html;
      flutterWebviewPlugin.close();
      flutterWebviewPlugin.launch(
          Uri.dataFromString(_url, mimeType: 'text/html', encoding: utf8)
              .toString(),
          hidden: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///原来是用来做SliverAppBar的背景图片加载，但是用不了SliverAppBar
    ///final double _imgWidth = MediaQuery.of(context).size.width;
    ///final double _imgHeight = _imgWidth * GOLDEN_RATIO;
    ///

    ///TODO 目前已知问题，1.iOS无法正产展示，Android可以，并且会多出一块白屏

    return WebviewScaffold(
      withJavascript: true,
      hidden: true,
      initialChild: LoadingView(),
      appBar: AppBar(
        title: Container(
            child: Text(widget.title,
                style: TextStyle(fontSize: 15),
                softWrap: true,
                overflow: TextOverflow.fade)),
      ),
    );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
