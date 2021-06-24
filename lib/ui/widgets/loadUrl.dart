// @dart=2.12

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/pages/setwallpaper.dart';

class LoadImage extends StatelessWidget {
  final String url;
  const LoadImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageView(imgUrl: url)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: url,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
