import 'package:flutter/material.dart';
import 'package:flutter_cybird/ui/daily/Daily.dart';
import 'package:flutter_cybird/ui/girls/Girls.dart';
import 'package:flutter_cybird/ui/movie/Movie.dart';
import 'package:flutter_cybird/ui/one/One.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
        color: Colors.green[800],
        body: MoviePage(),
      ),
      AppPage(
          icon: Icon(Icons.bookmark),
          title: 'Daily',
          color: Colors.blue[800],
          body: DailyPage()),
      AppPage(
          icon: Icon(Icons.whatshot),
          title: 'Girls',
          color: Colors.pinkAccent.shade200,
          body: GirlsPage()),
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

  Widget _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Botasky'),
            accountEmail: const Text('siriusabo@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/ic_launcher_round.png'),
            ),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: _items[_currentIndex]._color,
              image: DecorationImage(image: AssetImage('assets/images/bg_drawer.jpeg'), fit: BoxFit.cover)
            ),
            onDetailsPressed: () {},
            otherAccountsPictures: <Widget>[],
          ),
          MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: Expanded(
              child: Column(
                children: <Widget>[
                  ListTile(title: Text("一个"), onTap: (){_tempSnackbar();}),
                  ListTile(title: Text("电影"), onTap: (){_tempSnackbar();}),
                  ListTile(title: Text("日报"), onTap: (){_tempSnackbar();}),
                  ListTile(title: Text("美女"), onTap: (){_tempSnackbar();}),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  _tempSnackbar(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("未实现功能")));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
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
              .map<BottomNavigationBarItem>((AppPage appPage) => appPage.item)
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
  AppPage({Widget icon, String title, Color color, this.body})
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
