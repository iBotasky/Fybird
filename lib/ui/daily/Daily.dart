import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/daily/data/DailyData.dart';
import 'package:flutter_cybird/uitl/NavigatorUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> with AutomaticKeepAliveClientMixin<DailyPage>{
  Load _loadType = Load.LOADING;
  DailyData _dailyData;
  Dio _dio;

  @override
  void initState() {
    super.initState();

    _dio = Dio(Options(
      baseUrl: URL_ZHIHU_HOST,
      connectTimeout: 10000,
      receiveTimeout: 3000,
    ));

    _getDailyDatas();
  }

  Future<void> _getDailyDatas() async {
    Response response = await _dio.get(URL_ZHIHU_HOST + 'latest');
    setState(() {
      _loadType = Load.LOAD_COMPLETE;
      _dailyData = DailyData.fromJson(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return this._loadType != Load.LOADING
        ? RefreshIndicator(
            onRefresh: _getDailyDatas,
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return HeadBanner(topStories: _dailyData.topStories);
                } else if (index == _dailyData.stories.length + 1) {
                  return FooterView();
                } else {
                  return DailyItem(stories: _dailyData.stories[index - 1]);
                }
              },
              itemCount: _dailyData.stories.isEmpty
                  ? 0
                  : _dailyData.stories.length + 2,
            ))
        : LoadingView();
  }

  @override
  bool get wantKeepAlive => true;
}

class HeadBanner extends StatelessWidget {
  final List<TopStories> topStories;

  const HeadBanner({Key key, this.topStories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        child: Swiper(
          itemBuilder: (context, index) {
            return Stack(children: <Widget>[
              FadeInImage.assetNetwork(
                  width: MediaQuery.of(context).size.width,
                  placeholder: ASSETS_IMAGE_HOLDER,
                  fit: BoxFit.cover,
                  image: topStories[index].image),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      // Colors are easy thanks to Flutter's
                      // Colors class.
                      Color.fromARGB(210, 0, 0, 0),
                      Color.fromARGB(100, 0, 0, 0),
                      Color.fromARGB(30, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ))),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 20, bottom: 25, right: 20),
                  child: Text(
                    topStories[index].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ]);
          },
          onTap: (index) => NavigatorUtils.toDailyDetail(
              context,
              topStories[index].title,
              "${topStories[index].id}",
              topStories[index].image),
          itemCount: topStories.isEmpty ? 0 : topStories.length,
          pagination: SwiperPagination(
              margin: EdgeInsets.all(5),
              builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.blue[800],
                  color: Colors.white,
                  size: 8,
                  activeSize: 8)),
          controller: SwiperController(),
          loop: true,
          autoplay: true,
        ));
  }
}

class DailyItem extends StatelessWidget {
  final Stories stories;

  const DailyItem({Key key, this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
        child: Card(
            elevation: 3.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                        placeholder: ASSETS_IMAGE_HOLDER,
                        image: stories.images[0],
                        width: 70,
                        height: 70),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Expanded(
                        child: Text(
                      stories.title,
                      style: TextStyle(fontSize: 15),
                    ))
                  ],
                ),
              ),
              onTap: () => NavigatorUtils.toDailyDetail(
                  context, stories.title, "${stories.id}", stories.images[0]),
            )));
  }
}
