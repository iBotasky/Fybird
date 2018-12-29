import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/Home.dart';
import 'package:flutter_cybird/ui/SplashScreen.dart';

//void main() => runApp(MaterialApp(
//      title: 'Fybird',
//      theme: ThemeData(primaryColor: Colors.blue[800]),
//      home: SplashScreen(),
//      routes: {
//        HOME_SCREEN: (BuildContext context) => HomePage(),
//        ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
//      },
//    ));
void main() => runApp(MaterialApp(
      title: 'Fybird',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue[800]),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('First Page'),
          ),
          body: TabBarView(
            children: [
              TabView(),
              TabView(),
              TabView(),
            ],
          ),
        ),
      ),
    ));

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    debugPrint("Tab View init");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage()));
            },
            child: Text("Init all TabViews and tap to New Page"),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
                "Back to the first page, and tap the TapView will init again, not alive.")),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
