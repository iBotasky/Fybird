import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/movie/MovieData.dart';

enum Category { IN_THEATERS, COMING_SOON, TOP250 }

class MovieSection extends StatefulWidget {
  final Category category;

  const MovieSection({Key key, this.category}) : super(key: key);

  @override
  _MovieSectionState createState() => _MovieSectionState();
}

class _MovieSectionState extends State<MovieSection>
    with AutomaticKeepAliveClientMixin<MovieSection> {
  //使用这个就不会重新创建一个Widget
  final _count = 20;
  String _title;
  String _url;
  int _start;
  List<Subjects> _datas = List();

  @override
  void initState() {
    super.initState();
    switch (widget.category) {
      case Category.IN_THEATERS:
        _title = "影院热映";
        _url = 'v2/movie/in_theaters';
        break;
      case Category.COMING_SOON:
        _title = "即将上映";
        _url = 'v2/movie/coming_soon';
        break;
      case Category.TOP250:
        _title = "豆瓣250";
        _url = 'v2/movie/top250';
        break;
    }

    getFilmsData();
  }

  Future<void> getFilmsData() async {
    final _dio = Dio();
    List<Subjects> datas = List();
    Response response = await _dio
        .get(URL_MOVIE_HOST + _url, data: {"start": _start, "count": _count});
    datas.addAll(MovieData.fromJson(response.data).subjects);

    setState(() {
      _datas.addAll(datas);
      _start = _datas.length + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                child: Text(_title,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
          } else if (index == _datas.length + 1) {
            return LoadMoreView();
          } else {
            return MovieItem(subjects: _datas[index - 1]);
          }
        },
        itemCount: _datas == null || _datas.isEmpty ? 0 : _datas.length + 2,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MovieItem extends StatelessWidget {
  final Subjects subjects;

  const MovieItem({Key key, this.subjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: ASSETS_IMAGE_HOLDER,
            image: subjects.images.large,
            width: MediaQuery.of(context).size.width / 2.5,
            height: 260,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
          ),
          Expanded(
              child: Container(
                  height: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subjects.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(subjects.getGenres()),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("导演:${subjects.getDirectors()}"),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("演员:${subjects.getFirstThreeCasts()}"),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("评分:"),
                            Row(children: [
                              StarRating(
                                starCount: 5,
                                rating: subjects.rating.average / 2,
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              Text("${subjects.rating.average}", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),)
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
