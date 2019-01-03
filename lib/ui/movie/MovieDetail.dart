import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/movie/data/MovieDetailData.dart';
import 'package:flutter_cybird/uitl/NavigatorUtils.dart';

/// AppBarBehavior
//enum AppBarBehavior { normal, pinned, floating, snapping }

class MovieDetail extends StatefulWidget {
  final String title;
  final String id;
  final String imageUrl;

  static const String routeName = '/movie/movie_detail';

  const MovieDetail({Key key, this.title, this.id, this.imageUrl})
      : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final double _appBarHeight = 350.0;
  final double _imageHeight = 220.0;

  bool _isLoadComplete = false;

  Dio _dio;
  MovieDetailData _movieDetailData;

  @override
  void initState() {
    super.initState();

    _dio = Dio(Options(
        baseUrl: URL_MOVIE_HOST, connectTimeout: 10000, receiveTimeout: 3000));

    _getMovieDetail();
  }

  //数据请求
  Future<void> _getMovieDetail() async {
    Response response = await _dio.get('subject/${widget.id}');
    _movieDetailData = MovieDetailData.fromJson(response.data);
    setState(() {
      _isLoadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title:
                  Text(widget.title == null ? "Title is null" : widget.title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/images/bg_detail.jpeg',
                    fit: BoxFit.cover,
                    height: _appBarHeight,
                  ),
                  Center(
                    child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(),
                        child: CachedNetworkImage(
                          placeholder: Image.asset(
                            ASSETS_IMAGE_HOLDER,
                            width: _imageHeight * GOLDEN_RATIO,
                            height: _imageHeight,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: widget.imageUrl,
                          height: _imageHeight,
                          width: _imageHeight * GOLDEN_RATIO,
                        )),
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isLoadComplete
              ? _MovieDetailInfo(
                  data: _movieDetailData,
                )
              : SliverToBoxAdapter(
                  //这里暂时没有想法说去让LoadView居中，暂时加个Container实现居中
                  child: Container(height: 400, child: LoadingView()),
                )
        ],
      ),
    );
  }
}

class _MovieDetailInfo extends StatelessWidget {
  final MovieDetailData data;

  const _MovieDetailInfo({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      _HeadSection(
        data: data,
      ),
      _SummrySection(data: data),
      _CastSection(
        data: data.getMembers(),
      )
    ]));
  }
}

class _SummrySection extends StatelessWidget {
  final MovieDetailData data;

  const _SummrySection({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "简介",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(data.summary)
        ],
      ),
    );
  }
}

class _HeadSection extends StatelessWidget {
  final MovieDetailData data;

  const _HeadSection({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 135,
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              Text(data.year + "/" + data.getGenres(),
                  style: TextStyle(color: Colors.grey)),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 15,
                  child: Text("原名:${data.originalTitle}",
                      style: TextStyle(color: Colors.grey), softWrap: true))
            ],
          ),
          Card(
              shape: RoundedRectangleBorder(),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("豆瓣评分", style: TextStyle(color: Colors.grey)),
                    Text("${data.rating.average}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    StarRating(
                      starCount: 5,
                      size: 21,
                      rating: data.rating.average / 2.0,
                      color: Colors.amber,
                    ),
                    Text(
                      "${data.ratingsCount} mark",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class _CastSection extends StatelessWidget {
  final List<Members> data;

  const _CastSection({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270,
        margin: EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "演职员",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                  height: 240,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return _CastItem(member: data[index]);
                      },
                      separatorBuilder: (context, index) =>
                          VerticalDivider(width: 10, color: Colors.transparent),
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal))
            ]));
  }
}

class _CastItem extends StatelessWidget {
  final Members member;

  const _CastItem({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _itemWidth = 160 * GOLDEN_RATIO;
    final double _itemHeight = 160;
    return GestureDetector(
      onTap: () => NavigatorUtils.toWebView(
          context, member.name, member.alt, Colors.green[800]),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
              elevation: 3,
              shape: RoundedRectangleBorder(),
              child: CachedNetworkImage(
                  height: _itemHeight,
                  width: _itemWidth,
                  fit: BoxFit.cover,
                  placeholder: Image.asset(ASSETS_IMAGE_HOLDER,
                      width: _itemWidth, height: _itemHeight),
                  imageUrl: member.avatarUrl)),
          Container(
              width: _itemWidth,
              child: Text(member.name,
                  softWrap: false, overflow: TextOverflow.ellipsis)),
          Text(member.type == CastsType.director ? "导演" : "演员",
              style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      )),
    );
  }
}
