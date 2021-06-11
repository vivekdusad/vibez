import 'package:flutter/cupertino.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

enum wallpaperTypes {
  Home,
  Lock,
  Both,
}
const setAs = {
  wallpaperTypes.Home: WallpaperManager.HOME_SCREEN,
  wallpaperTypes.Both: WallpaperManager.BOTH_SCREENS,
  wallpaperTypes.Lock: WallpaperManager.LOCK_SCREEN
};

showActionSheet(BuildContext context) {
  var actionSheet = CupertinoActionSheet(
    title: Text("Set as"),
    actions: [
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(wallpaperTypes.Home);
          },
          child: Text("Home")),
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(wallpaperTypes.Lock);
          },
          child: Text("Lock")),
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(wallpaperTypes.Both);
          },
          child: Text("Both")),
    ],
  );
  return showCupertinoModalPopup(
      context: context, builder: (context) => actionSheet);
}
