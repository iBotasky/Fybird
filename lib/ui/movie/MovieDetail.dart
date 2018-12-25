import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/movie/data/MovieDetailData.dart';

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

  bool isLoadComplete = false;

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
      isLoadComplete = true;
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
                    child: FadeInImage.assetNetwork(
                      placeholder: ASSETS_IMAGE_HOLDER,
                      image: widget.imageUrl,
                      height: _imageHeight,
                      width: _imageHeight * GOLDEN_RATIO,
                    ),
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
          isLoadComplete
              ? _MovieDetailInfo(data: _movieDetailData,)
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
    return SliverList(delegate: SliverChildListDelegate([]));
  }
}





class _ContactItem extends StatelessWidget {
  _ContactItem({Key key, this.icon, this.lines, this.tooltip, this.onPressed})
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map<Widget>((String line) => Text(line))
        .toList();
    columnChildren.add(Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren))
    ];
    if (icon != null) {
      rowChildren.add(SizedBox(
          width: 72.0,
          child: IconButton(
              icon: Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed)));
    }
    return MergeSemantics(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren)),
    );
  }
}

class _ContactCategory extends StatelessWidget {
  const _ContactCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: themeData.dividerColor))),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: Icon(icon, color: themeData.primaryColor)),
              Expanded(child: Column(children: children))
            ],
          ),
        ),
      ),
    );
  }
}
