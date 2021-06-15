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
  const DownloadRow({Key key, this.imgUrl, this.savetogallaryBloc})
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
              return LoadingWidget();
            }
            return Buttons(
              icon: FaIcon(
                FontAwesomeIcons.download,
                color: Colors.white,
              ),
              onTap: () async {
                await _askPermission();
                savetogallaryBloc.add(SaveToGallaryRequested(url: imgUrl));
              },
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Buttons(
              icon: Text("Apply",
                  style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white)),
              onTap: () async {
                var wallpapertype = await showActionSheet(context);
                if (wallpapertype != null) {
                  var cachedImage =
                      await DefaultCacheManager().getSingleFile(imgUrl);
                  // ignore: unnecessary_null_comparison
                  if (cachedImage != null) {
                    var croppedImage = ImageCropper.cropImage(
                        sourcePath: cachedImage.path,
                        aspectRatio: CropAspectRatio(
                            ratioX: MediaQuery.of(context).size.width,
                            ratioY: MediaQuery.of(context).size.height));
                    // ignore: unnecessary_null_comparison
                    if (croppedImage != null) {
                      var result = await WallpaperManager.setWallpaperFromFile(
                          cachedImage.path, setAs[wallpapertype]);
                      print(result);
                    }
                  }
                }
              },
            ),
          ),
        ),
        Buttons(
            icon: FaIcon(
              FontAwesomeIcons.share,
              color: Colors.white,
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
