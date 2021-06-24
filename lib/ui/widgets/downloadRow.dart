import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
import 'package:wallpaper_app/ui/pages/setwallpaper.dart';
import 'package:wallpaper_app/ui/widgets/actionsheet.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class DownloadRow extends StatelessWidget {
  final SavetogallaryBloc savetogallaryBloc;
  final String imgUrl;
  final Image image ;
  final textcolor;
  DownloadRow({Key key, this.imgUrl, this.savetogallaryBloc, this.image,this.textcolor})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<SavetogallaryBloc, SavetogallaryState>(
          bloc: savetogallaryBloc,
          builder: (context, state) {
            if (state is SavetogallaryLoading) {
              return Buttons(icon: LoadingWidget(), onTap: (){},label: Text('Loading',style: GoogleFonts.openSans(color: textcolor),),);
            }
            return Buttons(
              label: Text('Save',style: GoogleFonts.openSans(color: textcolor),),
              icon: FaIcon(
                FontAwesomeIcons.download,
                size: 22,
                color: Colors.white,
              ),
              onTap: () async {
                await _askPermission();
                savetogallaryBloc.add(SaveToGallaryRequested(url: imgUrl));
              },
            );
          },
        ),
        Buttons(
          label: Text('Apply',style: GoogleFonts.openSans(color: textcolor),),
          icon: Icon(Icons.format_paint_sharp),
          onTap: () async {
            var wallpapertype = await showActionSheet(context);
            if (wallpapertype != null) {
              var cachedImage =
                  await DefaultCacheManager().getSingleFile(imgUrl);
              // ignore: unnecessary_null_comparison
              if (cachedImage != null) {
                var croppedImage = await ImageCropper.cropImage(
                    sourcePath: cachedImage.path,
                    aspectRatio: CropAspectRatio(
                        ratioX: MediaQuery.of(context).size.width,
                        ratioY: MediaQuery.of(context).size.height));
                // ignore: unnecessary_null_comparison
                if (croppedImage != null) {
                  await WallpaperManager.setWallpaperFromFile(
                      cachedImage.path, setAs[wallpapertype]);
                 // print(result);
                }
              }
            }
          },
        ),
        Buttons(
          label: Text('Share',style: GoogleFonts.openSans(color: textcolor),),
            icon: FaIcon(
              FontAwesomeIcons.share,
              color: Colors.white,
              size: 22,
            ),
            onTap: () {
              Share.share(
                  "download wallpaper app for amazing wallpapers $imgUrl #wallpapers #VibZ ");
            }),
      ],
    );
  }

  _askPermission() async {
    if (await Permission.contacts.request().isGranted) {
      return;
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
  }
}
