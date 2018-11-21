import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/movie/MovieSection.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<MovieSection> _sections;

  @override
  void initState() {
    super.initState();
    _sections = new List();
    _sections.add(MovieSection(
      category: Category.TOP250,
    ));
    _sections.add(MovieSection(
      category: Category.IN_THEATERS,
    ));
    _sections.add(MovieSection(
      category: Category.COMING_SOON,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (index){
        print("current index is $index");
      },
      itemBuilder: (context, index) {
        return _sections[index];
      },
      itemCount: _sections.length,
    );
  }
}
