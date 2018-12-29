import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/daily/Daily.dart';
import 'package:flutter_cybird/ui/girls/Girls.dart';
import 'package:flutter_cybird/ui/movie/Movie.dart';
import 'package:flutter_cybird/ui/one/One.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<AppPage> _items;
  int _currentIndex = 0;
  BottomNavigationBarType _bottomBarType = BottomNavigationBarType.shifting;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _items = [
      AppPage(
          icon: Icon(Icons.account_circle),
          title: 'One',
          color: Colors.black87,
          body: OnePage()),
      AppPage(
        icon: Icon(Icons.movie_filter),
        title: 'Movie',
        color: Colors.green,
        body: MoviePage(),
      ),
      AppPage(
        icon: Icon(Icons.bookmark),
        title: 'Daily',
        color: Colors.blue[800],
        body: DailyPage()
      ),
      AppPage(
        icon: Icon(Icons.whatshot),
        title: 'Girls',
        color: Colors.pinkAccent.shade200,
        body: GirlsPage()
      ),
    ];
    _controller = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPages() {
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        return _items[index].body;
      },
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: _items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: _bottomBarType == BottomNavigationBarType.shifting
                ? _items[_currentIndex]._color
                : Colors.blue[800],
            title: Center(
              child: Text(_items[_currentIndex]._title),
            ),
          ),
          body: Center(
            child: _buildPages(),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: _bottomBarType,
              items: _items
                  .map<BottomNavigationBarItem>(
                      (AppPage appPage) => appPage.item)
                  .toList(),
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  //这边用animate的话会造成底部bottomnavigator一个个点击过去。
//                  _controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  _controller.jumpToPage(index);
                  _currentIndex = index;
                });
              }),
        );
  }

  @override
  bool get wantKeepAlive => true;
}

class AppPage {
  AppPage(
      {Widget icon, String title, Color color, this.body})
      : this._title = title,
        this._color = color,
        this.item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
          backgroundColor: color,
        );

  final String _title;
  final Color _color;
  final BottomNavigationBarItem item;
  final Widget body;
}
