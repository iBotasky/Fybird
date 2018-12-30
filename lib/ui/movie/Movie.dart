import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/movie/MovieSection.dart';

///FAB的Action方法该怎么传递？GlobalKey?
class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with AutomaticKeepAliveClientMixin<MoviePage> {
  List<MovieSection> _sections;
  PageController _controller;
  Category _currentCategory;
  GlobalKey<MovieSectionState> _currentSectionKey;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();

    _sections = [
      MovieSection(
        key:  GlobalKey<MovieSectionState>(),
        category: Category.TOP250,
      ),
      MovieSection(
        key:  GlobalKey<MovieSectionState>(),
        category: Category.IN_THEATERS,
      ),
      MovieSection(
        key:  GlobalKey<MovieSectionState>(),
        category: Category.COMING_SOON,
      )
    ];
    _currentSectionKey = _sections[0].key;
    _currentCategory = Category.TOP250;
    _controller = PageController(initialPage: 0, keepPage: true);
  }

  FloatingActionButton _buildFloatingAction() {
    return FloatingActionButton(
      key:ValueKey(_currentCategory),//这个key用来创建不同的button，有动画
      backgroundColor: Colors.green[800],
      child: Icon(Icons.arrow_upward),
      onPressed: () {
        _currentSectionKey.currentState.toTop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _buildFloatingAction(),
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentCategory = _sections[index].category;
            _currentSectionKey = _sections[index].key;
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
