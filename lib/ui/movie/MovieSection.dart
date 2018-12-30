import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/movie/data/MovieData.dart';
import 'package:flutter_cybird/uitl/NavigatorUtils.dart';

enum Category { IN_THEATERS, COMING_SOON, TOP250 }

class MovieSection extends StatefulWidget {
  final Category category;

  const MovieSection({Key key, this.category}) : super(key: key);

  @override
  MovieSectionState createState() => MovieSectionState();
}

class MovieSectionState extends State<MovieSection>
    with AutomaticKeepAliveClientMixin<MovieSection> {
  //使用这个AutomaticKeepAliveClientMixin就不会重新创建一个Widget

  final _count = 20;
  String _title;
  String _url;
  int _start;
  bool _isLoadComplete = false;
  bool _isDatasEmpty = false;
  List<Subjects> _datas;
  ScrollController _controller;
  Dio _dio;

  toTop(){
    _controller.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void initState() {
    super.initState();
    switch (widget.category) {
      case Category.IN_THEATERS:
        _title = "影院热映";
        _url = 'in_theaters';
        break;
      case Category.COMING_SOON:
        _title = "即将上映";
        _url = 'coming_soon';
        break;
      case Category.TOP250:
        _title = "豆瓣250";
        _url = 'top250';
        break;
    }
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getFilmsData(Load.LOAD_MORE);
      }
    });

    _dio = Dio(Options(
      baseUrl: URL_MOVIE_HOST,
      connectTimeout: 10000,
      receiveTimeout: 3000,
    ));

    _getFilmsData(Load.REFRESH);
  }

  Future<void> _handleDatas() {
    return _getFilmsData(Load.REFRESH);
  }

  Future<void> _getFilmsData(Load loadType) async {
    List<Subjects> datas = List();
    Response response = await _dio.get(_url, data: {
      "start": loadType == Load.REFRESH ? 0 : _start,
      "count": _count
    });
    datas.addAll(MovieData.fromJson(response.data).subjects);
    setState(() {
      if (loadType == Load.REFRESH) {
        _datas = datas;
      } else {
        _datas.addAll(datas);
      }

      if (datas.isEmpty) {
        _isDatasEmpty = true;
      }

      _start = _datas.length;
      _isLoadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return Scaffold(
        body: Container(
      child: _isLoadComplete
          ? RefreshIndicator(
              onRefresh: _handleDatas,
              child: ListView.separated(
                controller: _controller,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                        child: Text(_title,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)));
                  } else if (index == _datas.length + 1) {
                    return _isDatasEmpty ? FooterView() : LoadMoreView();
                  } else {
                    return InkWell(
                        onTap: () => NavigatorUtils.toMovieDetail(
                            context,
                            _datas[index - 1].title,
                            _datas[index - 1].id,
                            _datas[index - 1].images.large),
                        child: MovieItem(subjects: _datas[index - 1]));
                  }
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.transparent,
                    ),
                itemCount:
                    _datas == null || _datas.isEmpty ? 0 : _datas.length + 2,
              ))
          : LoadingView(),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

class MovieItem extends StatelessWidget {
  final Subjects subjects;

  const MovieItem({Key key, this.subjects}) : super(key: key);

  List<Widget> getGenersWidgets() {
    List<Widget> geners = List();
    for (String s in subjects.genres) {
      geners.add(Chip(
        label: Text(
          s,
          style: TextStyle(fontSize: 12),
        ),
        labelPadding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        padding: EdgeInsets.all(5),
      ));
    }
    return geners;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2.5;
    final double height = width / GOLDEN_RATIO;
    TextStyle textStyle =
        TextStyle(fontSize: (Platform.isAndroid ? 12 : 14));
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 0),
      child: Row(
        children: <Widget>[
          Card(
              elevation: 4,
              shape: RoundedRectangleBorder(),
              child: FadeInImage.assetNetwork(
                placeholder: ASSETS_IMAGE_HOLDER,
                image: subjects.images.large,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Expanded(
              child: Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subjects.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                          softWrap: false,
                          overflow: TextOverflow.fade),
                      Wrap(
                        spacing: 3.0,
                        alignment: WrapAlignment.start,
                        children: getGenersWidgets(),
                      ),
                      Text("导演:${subjects.getDirectors()}", style: textStyle),
                      Text(
                        "演员:${subjects.getFirstThreeCasts()}",
                        style: textStyle,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("评分:",style: textStyle),
                            Row(children: [
                              StarRating(
                                starCount: 5,
                                color: Colors.amber,
                                rating: subjects.rating.average / 2,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text(
                                "${subjects.rating.average}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ])
                          ],
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
