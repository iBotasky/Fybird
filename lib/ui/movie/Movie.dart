import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/movie/MovieSection.dart';
///FAB的Action方法该怎么传递？GlobalKey?
class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin<MoviePage>{
  List<MovieSection> _sections;
  PageController _controller;
  Category _currentCategory;
  int _currentIndex;
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

  FloatingActionButton _buildFloatingAction() {
    Color _color = Colors.blue[800];
    if(_currentCategory == Category.TOP250){
      _color = Colors.blue[800];
    }else if(_currentCategory == Category.IN_THEATERS){
      _color = Colors.green[800];
    }else{
      _color = Colors.red[800];
    }

    return FloatingActionButton(
      backgroundColor: _color,
      child: Icon(Icons.arrow_upward),
      onPressed: (){
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingAction(),
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentCategory = _sections[index].category;
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _sections[index];
        },
        itemCount: _sections.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
