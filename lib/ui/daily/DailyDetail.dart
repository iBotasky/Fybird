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
  bool _isLoadComplete = false;
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
    Response response = await _dio.get("${widget.id}");
    _dailyData = DailyDetailData.fromJson(response.data);
    String css =
        '''<link rel="stylesheet" href="${_dailyData.css[0]}" type="text/css">''';
    String s = '''<div class="img-place-holder"></div>''';
    String html =
        '''<html><head>$css</head><body>${_dailyData.body.replaceAll(s, "")}</body></html>''';
    _url = html;
    setState(() {
      _isLoadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///原来是用来做SliverAppBar的背景图片加载，但是用不了SliverAppBar
    ///final double _imgWidth = MediaQuery.of(context).size.width;
    ///final double _imgHeight = _imgWidth * GOLDEN_RATIO;
    ///

    ///TODO 目前已知问题，1.iOS无法正产展示，Android可以，并且会多出一块白屏 2.数据要一开始就初始化好，url不能通过setState来切换，导致我目前只能初始化创建一个loading的Scaffold。

    return _isLoadComplete
        ? WebviewScaffold(
            withJavascript: true,
            url: Uri.dataFromString(_url, mimeType: 'text/html', encoding: utf8)
                .toString(),
            appBar: AppBar(
              title: Container(
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 15),
                      softWrap: true,
                      overflow: TextOverflow.fade)),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Container(
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 15),
                      softWrap: true,
                      overflow: TextOverflow.fade)),
            ),
            body: LoadingView(),
          );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
