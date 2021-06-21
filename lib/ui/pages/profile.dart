import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ME",
          style: TextStyle(color: Colors.teal, fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10),
                  Text("How to set live Wallpaper")
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 10),
                  Text("Tell a friend")
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(FontAwesomeIcons.facebookMessenger),
                  SizedBox(width: 10),
                  Text("feedback")
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.perm_device_information),
                  SizedBox(width: 10),
                  Text("About Us")
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(FontAwesomeIcons.moon),
                  SizedBox(width: 10),
                  Text("Night Mode")
                ],
              ),
              trailing: Switch(
                value: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
