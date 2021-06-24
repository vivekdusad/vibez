// @dart=2.12
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/services/thememanager.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/ui/widgets/downloadRow.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
class ImageView extends StatelessWidget {
  final String imgUrl;
  ImageView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);


  Future<Color> colorgenerator()async
  {
    Future<Size> _calculateImageDimension() {
      Completer<Size> completer = Completer();
      Image image = Image.network(imgUrl);
      image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
              (ImageInfo image, bool synchronousCall) {
            var myImage = image.image;
            Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
            completer.complete(size);
          },
        ),
      );
      return completer.future;
    }
    Size imgSize=await _calculateImageDimension();
    PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      NetworkImage(imgUrl),
      size: Size(imgSize.width,imgSize.height),
      region:  Offset(0,imgSize.height-50) & Size(imgSize.width,30)
    );
    
    var textcolor=paletteGenerator.dominantColor!.color;


    double temp=textcolor.computeLuminance();
    //print('lumini');
    //print(temp);
    if(temp>0.5){
      textcolor=Colors.black;
    }
    else textcolor=Colors.white;

    return textcolor;
  }
  @override
  Widget build(BuildContext context) {
    SavetogallaryBloc savetogallaryBloc = SavetogallaryBloc();
    ThemeManager.setStatusbar(Colors.transparent, Brightness.light);
    return WillPopScope(
      onWillPop: ()async {  var statusColor=(ThemeManager.notifier.value==ThemeMode.dark)?Colors.black:Colors.white.withAlpha(250);
      var iconColors=(ThemeManager.notifier.value==ThemeMode.dark)?Brightness.light:Brightness.dark;
      ThemeManager.setStatusbar(statusColor, iconColors);
      return true;
      },
      child: FutureBuilder(
        future: colorgenerator(),
        builder:(context,data){
            if(data.connectionState==ConnectionState.waiting)
              return LoadingWidget();
            else
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
                  Image.network(imgUrl,fit:BoxFit.cover,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),
                  DownloadRow(
                    imgUrl: imgUrl,
                    savetogallaryBloc: savetogallaryBloc,
                    textcolor:data.data
                  ),
//              Positioned(
//                  top: 20,
//                  left: 10,
//                  child: Buttons(
//                    icon:Icon(Icons.keyboard_backspace),
//                    onTap: () {
//                      Navigator.pop(context);
//                    },
//                  )),
          ],
              ),
            )
          )
          );
        },
      ),
    );
  }

  
}

class Buttons extends StatelessWidget {
  final Widget icon;
  final Function onTap;
  final Text label;
  const Buttons({Key? key, required this.icon, required this.onTap,required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (icon is Icon?Colors.indigo:Colors.white.withOpacity(0.25)),
            ),
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: icon,
              onPressed: () {
                onTap();
              },
            ),
          ),
          SizedBox(height: 5,),
          label
        ],
      ),
    );
  }
}
