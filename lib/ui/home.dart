import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String _text = '';
  List<BottomItem> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <BottomItem>[
      BottomItem(icon: Icon(Icons.account_circle), title: 'One', vsync: this),
      BottomItem(icon: Icon(Icons.movie_filter), title: 'Movie', vsync: this),
      BottomItem(icon: Icon(Icons.book), title: 'Daily', vsync: this)
    ];
    for (BottomItem view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  void dispose() {
    for (BottomItem view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {},
        theme: ThemeData(primaryColor: Colors.blue[800]),
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text(_navigationViews[_currentIndex]._title),),
          ),
          body: Center(child: _buildTransitionsStack()),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _navigationViews
                  .map<BottomNavigationBarItem>(
                      (BottomItem navigationView) => navigationView.item)
                  .toList(),
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  //界面切换
                  _navigationViews[_currentIndex].controller.reverse();
                  _currentIndex = index;
                  _navigationViews[_currentIndex].controller.forward();
                });
              }),
        ));
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (BottomItem view in _navigationViews)
      transitions.add(view.transition(BottomNavigationBarType.fixed, context));
    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }
}

class BottomItem {
  BottomItem({String title, Icon icon, TickerProvider vsync})
      : _icon = icon,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        controller = AnimationController(
            duration: kThemeAnimationDuration, vsync: vsync) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final String _title;
  final Icon _icon;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    final ThemeData themeData = Theme.of(context);
    iconColor = themeData.brightness == Brightness.light
        ? themeData.primaryColor
        : themeData.accentColor;

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}
