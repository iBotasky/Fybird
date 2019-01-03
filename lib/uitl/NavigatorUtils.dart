import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/daily/DailyDetail.dart';
import 'package:flutter_cybird/ui/girls/GirlsDetail.dart';
import 'package:flutter_cybird/ui/movie/MovieDetail.dart';
import 'package:flutter_cybird/ui/web/WebView.dart';

class NavigatorUtils {
  ///跳转到电影详情页面
  static toMovieDetail(
      BuildContext context, String title, String id, String imageUrl) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetail(
                  title: title,
                  id: id,
                  imageUrl: imageUrl,
                )));
  }

  ///跳转到日报详情
  static toDailyDetail(
      BuildContext context, String title, String id, String imgUrl) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DailyDetail(title: title, id: id)));
  }

  ///跳到有URL的webview
  static toWebView(BuildContext context, String title, String url, Color barColor) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebView(
                  title: title,
                  url: url,
                  color: barColor,
                )));
  }


  ///跳到图片详情页面
  static toPhotoDetail(BuildContext context, String url){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GirlsDetail(url: url,)));
  }
}
