import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageView extends StatelessWidget {
  final String imgUrl;
  const ImageView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Buttons(
                icon: FontAwesomeIcons.download,
                onTap: () {
                  print("downloaded");
                },
              ),
              Buttons(
                icon: FontAwesomeIcons.share,
                onTap: () {
                  print("Shared");
                },
              ),
              Buttons(
                icon: FontAwesomeIcons.brush,
                onTap: () {
                  print("Applied");
                },
              ),
            ],
          )
        ],
      ),
    );
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
