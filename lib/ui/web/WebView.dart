import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//class WebView extends StatefulWidget {
//  @override
//  _WebViewState createState() => _WebViewState();
//}
//
//class _WebViewState extends State<WebView> {
//  @override
//  Widget build(BuildContext context) {
//    return WebviewScaffold(
//
//    );
//  }
//}

class WebView extends StatelessWidget {
  final String url;
  final String title;
  final Color color;

  const WebView({Key key, this.url, this.title, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      withJavascript: true,
      hidden: true,
      initialChild: LoadingView(),
      appBar: AppBar(
        backgroundColor: color,
        title: Container(
          child: Text(title),
        ),
      ),
    );
  }
}
