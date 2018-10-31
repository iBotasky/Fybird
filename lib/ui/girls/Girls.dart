import 'package:flutter/material.dart';
import 'package:flutter_cybird/constant/Constant.dart';

class GirlsPage extends StatefulWidget {
  @override
  _GirlsPageState createState() => _GirlsPageState();
}

class _GirlsPageState extends State<GirlsPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(100, (index) {
        return Container(
            height: 300.0,
            margin: EdgeInsets.all(5),
            child: Card(
              child: Stack(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: ASSETS_IMAGE_HOLDER,
                      image:
                          'https://ws1.sinaimg.cn/mw600/007awY0bly1fwp4f5v6yhj30m80tm7dw.jpg')
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
              elevation: 4,
            ));
      }),
    );
  }
}
