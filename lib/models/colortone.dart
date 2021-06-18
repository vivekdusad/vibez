import 'package:flutter/material.dart';

class Colortone {
  final String id;
  final Color color;

  Colortone({this.id, this.color});
}

List<Colortone> colortones = [
  Colortone(id: "red", color: Colors.red),
  Colortone(id: "amber", color: Colors.amber),
  Colortone(id: "orange", color: Colors.deepOrange),
  Colortone(id: "purple", color: Colors.purple),
  Colortone(id: "blue", color: Colors.blue),
  Colortone(id: "Green", color: Colors.lightGreen),
  Colortone(id: "pink", color: Color(0xffFF1493)),
  Colortone(id: "teal", color: Colors.tealAccent),
  Colortone(id: "yellow", color: Colors.yellowAccent),
  Colortone(id: "cyan", color: Colors.cyanAccent),
];
