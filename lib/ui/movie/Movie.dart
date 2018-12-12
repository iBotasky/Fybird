import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/movie/MovieSection.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<MovieSection> _sections;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _sections = [
      MovieSection(
        category: Category.TOP250,
      ),
      MovieSection(
        category: Category.IN_THEATERS,
      ),
      MovieSection(
        category: Category.COMING_SOON,
      )
    ];
    _controller = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) {
        print("current index is $index");
      },
      itemBuilder: (context, index) {
        return _sections[index];
      },
      itemCount: _sections.length,
    );
  }
}
