import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _text = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = 0;
      _text = 'One';
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {},
        theme: ThemeData(primaryColor: Colors.blue[800]),
        home: Scaffold(
          body: Center(
            child: Text(_text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text('One')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.movie_filter),
                    title: Text('Movie')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    title: Text('Daily'))
              ],
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                  switch(index){
                    case 0:
                      _text =  'ONE';
                      break;
                    case 1:
                      _text = 'Movie';
                      break;
                    case 2:
                      _text = 'Daily';
                      break;
                  }
                });
              }),
        ));
  }
}
