import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/daily.dart';
import 'package:flutter_cybird/ui/movie.dart';
import 'package:flutter_cybird/ui/one.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<BottomItem> _navigationViews;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _navigationViews = <BottomItem>[
      BottomItem(icon: Icon(Icons.account_circle), title: 'One', vsync: this),
      BottomItem(icon: Icon(Icons.movie_filter), title: 'Movie', vsync: this),
      BottomItem(icon: Icon(Icons.book), title: 'Daily', vsync: this)
    ];

    _children = [
      OnePage(),
      MoviePage(),
      DailyPage()
    ];
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {},
        theme: ThemeData(primaryColor: Colors.blue[800]),
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(_navigationViews[_currentIndex]._title),
            ),
          ),
          body: Center(
            child: _children[_currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _navigationViews
                  .map<BottomNavigationBarItem>(
                      (BottomItem navigationView) => navigationView.item)
                  .toList(),
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              }),
        ));
  }
}

class BottomItem {
  BottomItem({String title, Icon icon, TickerProvider vsync})
      : _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        );

  final String _title;
  final BottomNavigationBarItem item;
}
