// @dart=2.12
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/ui/widgets/actionsheet.dart';
import 'package:wallpaper_app/ui/widgets/downloadRow.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
// ignore: import_of_legacy_library_into_null_safe
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
              DownloadRow(
                imgUrl: imgUrl,
                savetogallaryBloc: savetogallaryBloc,
              ),
              Positioned(
                  top: 20,
                  left: 10,
                  child: Buttons(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        )));
  }

  
}

class Buttons extends StatelessWidget {
  final Widget icon;
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
          icon: icon,
          onPressed: () {
            onTap();
          },
        ),
      ),
    );
  }
}
