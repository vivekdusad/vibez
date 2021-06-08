import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CupertinoSearchTextField(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Best of the Month",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        width: 60,
                        height: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                        ),
                        width: 60,
                        height: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                        ),
                        width: 60,
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: new List<Widget>.generate(16, (index) {
                      return new GridTile(
                        child: new Card(
                            color: Colors.blue.shade200,
                            child: new Center(
                              child: new Text('tile $index'),
                            )),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            backgroundColor: Colors.yellow),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          backgroundColor: Colors.blue,
        ),
      ], elevation: 10),
    );
  }
}
