

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class GirlsDetail extends StatelessWidget {
  final String url;

  const GirlsDetail({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        )
    );
  }
}
