import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/girls/data/GirlsData.dart';

class GirlsPage extends StatefulWidget {
  @override
  _GirlsPageState createState() => _GirlsPageState();
}

class _GirlsPageState extends State<GirlsPage>
    with AutomaticKeepAliveClientMixin<GirlsPage> {
  int _page = 1;
  bool _isLoading = true;
  List<Results> _datas = List();
  ScrollController _controller = ScrollController();
  Dio _dio;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getGirlsData();
      }
    });

    _dio = Dio(Options(
      baseUrl: URL_GANK_HOST,
      connectTimeout: 10000,
      receiveTimeout: 3000,
    ));

    _getGirlsData();
  }

  Future<void> _getGirlsData() async {
    List<Results> datas = List();
    Response response = await _dio.get('/api/data/福利/20/$_page');
    datas.addAll(GirlsData.fromJson(response.data).results);
    setState(() {
      _datas.addAll(datas);
      _isLoading = false;
      _page += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return _isLoading
        ? LoadingView()
        : GridView.count(
            controller: _controller,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisCount: 2,
            // Generate 100 Widgets that display their index in the List
            childAspectRatio: GOLDEN_RATIO,
            children: List.generate(_datas.length, (index) {
              return PhotoView(girlsData: _datas[index]);
            }),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoView extends StatefulWidget {
  final Results girlsData;

  const PhotoView({Key key, this.girlsData}) : super(key: key);

  @override
  _PhotoViewState createState() => _PhotoViewState(this.girlsData);
}

class _PhotoViewState extends State<PhotoView> {
  final Results girlsData;

  _PhotoViewState(this.girlsData);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.all(4),
        child: Card(
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: Image.asset(
                    ASSETS_IMAGE_HOLDER,
                    width: width,
                    height: height,
                  ),
                  imageUrl: girlsData.url),
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      // Colors are easy thanks to Flutter's
                      // Colors class.
                      Color.fromARGB(150, 0, 0, 0),
                      Color.fromARGB(100, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )))
            ],
          ),
          shape: RoundedRectangleBorder(), //todo 这边嵌套图片后圆角会失效
          elevation: 3,
        ));
  }
}
