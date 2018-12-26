import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/daily/DailyDetail.dart';
import 'package:flutter_cybird/ui/movie/MovieDetail.dart';

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
            builder: (context) =>
                DailyDetail(title: title, id: id)));
  }
}
