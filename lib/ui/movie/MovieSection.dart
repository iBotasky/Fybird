import 'package:flutter/material.dart';

enum Category { IN_THEATERS, COMING_SOON, TOP250 }

class MovieSection extends StatefulWidget {
  final Category category;
  const MovieSection({Key key,this.category}) : super(key: key);

  @override
  _MovieSectionState createState() => _MovieSectionState();
}

class _MovieSectionState extends State<MovieSection> {
  String _title;

  @override
  void initState() {
    super.initState();
    switch(widget.category){
      case Category.IN_THEATERS:
        _title = "In Theaters";
        break;
      case Category.COMING_SOON:
        _title = "Coming Soon";
        break;
      case Category.TOP250:
        _title = "Top 250";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
