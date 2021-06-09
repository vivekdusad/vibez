import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

class ImageView extends StatelessWidget {
  static const platform = const MethodChannel('com.divyanshu.chitr/wallpaper');
  Future<void> _setWallpaper(int wallpaperType) async {
    var file = await DefaultCacheManager().getSingleFile(imgUrl);
    try {
      final int result = await platform
          .invokeMethod('setWallpaper', [file.path, wallpaperType]);
      print('Wallpaer Updated.... $result');
    } on PlatformException catch (e) {
      print("Failed to Set Wallpaer: '${e.message}'.");
    }
  }

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
          body: Stack(
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
                          "download wallpaper app for amazing wallpapers $imgUrl ");
                    },
                  ),
                  Buttons(
                    icon: FontAwesomeIcons.brush,
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ));
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
