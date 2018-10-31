import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';
import 'package:flutter_cybird/ui/base/BaseComponent.dart';
import 'package:flutter_cybird/ui/girls/GirlsData.dart';

class GirlsPage extends StatefulWidget {
  @override
  _GirlsPageState createState() => _GirlsPageState();
}

class _GirlsPageState extends State<GirlsPage> {
  int _page = 1;
  bool _isLoading = true;
  List<Results> _datas;

  Future<List<Results>> _getGirlsData() async {
    final _dio = Dio();
    List<Results> datas = List();
    Response response =
        await _dio.get(URL_GANK_HOST + '/api/data/福利/20/$_page');
    datas.addAll(GirlsData.fromJson(response.data).results);
    return datas;
  }

  @override
  void initState() {
    super.initState();
    _getGirlsData().then((value) {
      setState(() {
        _datas = value;
        _page += 1;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingView()
        : GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisCount: 2,
            // Generate 100 Widgets that display their index in the List
            childAspectRatio: GOLDEN_RATIO,
            children: List.generate(_datas.length, (index) {
              return Container(
                  margin: EdgeInsets.all(4),
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: ASSETS_IMAGE_HOLDER,
                            image: _datas[index].url),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    elevation: 2,
                  ));
            }),
          );
  }
}
