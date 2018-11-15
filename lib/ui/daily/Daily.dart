import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/daily/DailyData.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  Load _loadType = Load.LOADING;
  DailyData _dailyData;

  @override
  void initState() {
    super.initState();
    _getDailyDatas();
  }

  Future<void> _getDailyDatas() async {
    final _dio = Dio();
    Response response = await _dio.get(URL_ZHIHU_HOST + '/api/4/news/latest');
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return DailyItem(stories: _dailyData.stories[index]);
              },
              itemCount:
                  _dailyData.stories.isEmpty ? 0 : _dailyData.stories.length,
            ))
        : LoadingView();
  }
}

class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
                Expanded(child: Text(stories.title))
              ],
            ),
          )),
    );
  }
}
