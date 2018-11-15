import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/base/banner_widget.dart';
import 'package:flutter_cybird/ui/daily/DailyData.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  Load _loadType = Load.LOADING;
  DailyData _dailyData;
  List<String> _urls;

  @override
  void initState() {
    super.initState();
    _getDailyDatas();
  }

  Future<void> _getDailyDatas() async {
    final _dio = Dio();
    Response response = await _dio.get(URL_ZHIHU_HOST + '/api/4/news/latest');
//    for(TopStories top in _dailyData.topStories){
//      _urls.add(top.image);
//    }
    setState(() {
      _loadType = Load.LOAD_COMPLETE;
      _dailyData = DailyData.fromJson(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return this._loadType != Load.LOADING
        ? RefreshIndicator(
            onRefresh: _getDailyDatas,
//            child: BannerWidget(data: _urls, curve: null,),
            child: ListView.builder(
              itemBuilder: (context, index) {
//                if (index == 0) {
//                  return HeadBanner(topStories: _dailyData.topStories);
//                } else {
                  return DailyItem(stories: _dailyData.stories[index]);
//                }
              },
              itemCount: _dailyData.stories.isEmpty
                  ? 0
                  : _dailyData.stories.length,
            )
          )
        : LoadingView();
  }
}

//region首页轮播控件
class HeadBanner extends StatelessWidget {
  final List<TopStories> topStories;

  const HeadBanner({Key key, this.topStories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return FadeInImage.assetNetwork(
            width: double.infinity,
            height: 150.0,
            placeholder: ASSETS_IMAGE_HOLDER,
            image: topStories[index].image);
      },
      itemCount: topStories.isEmpty ? 0 : topStories.length,
    );
  }
}
//endregion

//region底部文章Item
class DailyItem extends StatelessWidget {
  final Stories stories;

  const DailyItem({Key key, this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: Card(
          elevation: 3.0,
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
          )),
    );
  }
}
//endregion
