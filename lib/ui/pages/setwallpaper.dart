// @dart=2.12
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
import 'package:wallpaper_app/ui/widgets/actionsheet.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageView extends StatelessWidget {
  final String imgUrl;
  const ImageView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SavetogallaryBloc savetogallaryBloc = SavetogallaryBloc();
    return BlocProvider(
        create: (context) => savetogallaryBloc,
        child: Scaffold(
            body: BlocListener<SavetogallaryBloc, SavetogallaryState>(
          listener: (context, state) {
            if (state is SaveToGallarySucess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Downloaded")));
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imgUrl), fit: BoxFit.fill)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<SavetogallaryBloc, SavetogallaryState>(
                    bloc: savetogallaryBloc,
                    builder: (context, state) {
                      if (state is SavetogallaryLoading) {
                        return LoadingWidget();
                      }
                      return Buttons(
                        icon: FontAwesomeIcons.download,
                        onTap: () async {
                          await _askPermission();
                          BlocProvider.of<SavetogallaryBloc>(context)
                              .add(SaveToGallaryRequested(url: imgUrl));
                        },
                      );
                    },
                  ),
                  Buttons(
                      icon: FontAwesomeIcons.share,
                      onTap: () {
                        Share.share(
                            "download wallpaper app for amazing wallpapers  ");
                      }),
                  Buttons(
                    icon: FontAwesomeIcons.brush,
                    onTap: () async {
                      var wallpapertype = await showActionSheet(context);
                      if (wallpapertype != null) {
                        var cachedImage =
                            await DefaultCacheManager().getSingleFile(imgUrl);
                        if (cachedImage != null) {
                          var croppedImage = ImageCropper.cropImage(
                              sourcePath: cachedImage.path,
                              aspectRatio: CropAspectRatio(
                                  ratioX: MediaQuery.of(context).size.width,
                                  ratioY: MediaQuery.of(context).size.height));
                          if (croppedImage != null) {
                            var result =
                                await WallpaperManager.setWallpaperFromFile(
                                    cachedImage.path, setAs[wallpapertype]);
                            print(result);
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
              Positioned(
                  top: 20,
                  left: 10,
                  child: Buttons(
                    icon: FontAwesomeIcons.arrowLeft,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        )));
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

class Buttons extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  const Buttons({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.25),
        ),
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: FaIcon(
            icon,
            color: Colors.white,
          ),
          onPressed: () {
            onTap();
          },
        ),
      ),
    );
  }
}
