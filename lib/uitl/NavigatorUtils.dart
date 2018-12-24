import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/movie/MovieDetail.dart';

class NavigatorUtils {
  static toMovieDetail(BuildContext context, String title, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetail(title: title, id: id)));
  }
}
