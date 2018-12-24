import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/daily/Daily.dart';
import 'package:flutter_cybird/ui/girls/Girls.dart';
import 'package:flutter_cybird/ui/movie/Movie.dart';
import 'package:flutter_cybird/ui/movie/MovieDetail.dart';
import 'package:flutter_cybird/ui/one/One.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<AppPage> _items;
  int _currentIndex = 0;
  BottomNavigationBarType _bottomBarType = BottomNavigationBarType.shifting;

  @override
  void initState() {
    super.initState();
    _items = [
      AppPage(
          icon: Icon(Icons.account_circle),
          title: 'One',
          color: Colors.black87,
          body: OnePage(),
          vsync: this),
      AppPage(
        icon: Icon(Icons.movie_filter),
        title: 'Movie',
        color: Colors.green,
        body: MoviePage(),
        vsync: this,
      ),
      AppPage(
        icon: Icon(Icons.bookmark),
        title: 'Daily',
        color: Colors.blueAccent.shade400,
        body: DailyPage(),
        vsync: this,
      ),
      AppPage(
        icon: Icon(Icons.whatshot),
        title: 'Girls',
        color: Colors.pinkAccent.shade200,
        body: GirlsPage(),
        vsync: this,
      ),
    ];

    for (AppPage view in _items) view.controller.addListener(_rebuild);

    _items[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (AppPage page in _items) {
      page.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildPageStack() {
    final List<Widget> transitions = <Widget>[];

    for (int i = 0; i < _items.length; i++) {
      transitions.add(IgnorePointer(
          ignoring: _currentIndex != i,
          child: _items[i].buildTransition(context)));
    }
    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fybird',
        theme: ThemeData(primaryColor: Colors.blue[800]),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: _bottomBarType == BottomNavigationBarType.shifting
                ? _items[_currentIndex]._color
                : Colors.blue[800],
            title: Center(
              child: Text(_items[_currentIndex]._title),
            ),
          ),
          body: Center(
            child: _buildPageStack(),
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
                  _items[_currentIndex].controller.reverse();
                  _currentIndex = index;
                  _items[_currentIndex].controller.forward();
                });
              }),
        ));
  }
}

class AppPage {
  AppPage(
      {Widget icon, String title, Color color, this.body, TickerProvider vsync})
      : this._title = title,
        this._color = color,
        this.controller = AnimationController(
            vsync: vsync, duration: Duration(milliseconds: 200)),
        this.item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
          backgroundColor: color,
        ) {
    _animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  }

  final String _title;
  final Color _color;
  final AnimationController controller;
  final BottomNavigationBarItem item;
  final Widget body;
  CurvedAnimation _animation;

  FadeTransition buildTransition(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: body,
    );
  }
}
