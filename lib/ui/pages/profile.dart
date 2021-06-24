import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
              onTap: (){
                //Todo
              },
              contentPadding: EdgeInsets.all(7),
              title: Row(
                children: [
                  Icon(CupertinoIcons.settings),
                  SizedBox(width: 10),
                  Text("How to set live Wallpaper")
                ],
              ),
            ),
            ListTile(
              onTap: (){
                //Todo
              },
              contentPadding: EdgeInsets.all(7),
              title: Row(
                children: [
                  Icon(CupertinoIcons.share),
                  SizedBox(width: 10),
                  Text("Tell a friend")
                ],
              ),
            ),
            ListTile(
              onTap: (){
                //Todo
              },
              contentPadding: EdgeInsets.all(7),
              title: Row(
                children: [
                  Icon(CupertinoIcons.mail),
                  SizedBox(width: 10),
                  Text("feedback")
                ],
              ),
            ),
            ListTile(
              onTap: (){
                //Todo
              },
              contentPadding: EdgeInsets.all(7),
              title: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 10),
                  Text("About Us")
                ],
              ),
            ),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(FontAwesomeIcons.moon),
            //       SizedBox(width: 10),
            //       Text("Night Mode")
            //     ],
            //   ),
            //   trailing: Switch(
            //     value: false,
            //     onChanged: (value) {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
