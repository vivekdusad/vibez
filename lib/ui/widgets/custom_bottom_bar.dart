import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants/constants.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  final List<CustomNavItem> items;
  int index;
  CustomBottomBar({Key key, this.items, this.index = 0}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: widget.items.map((item) => item.page).toList(),
          ),
          Material(
            elevation: 40,
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _widgetsBuilder(widget.items),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customNavItem(CustomNavItem item, index) {
    return GestureDetector(
      onTap: () {
        _changePage(index);
      },
      child: Container(
        padding: EdgeInsets.all(6),
        width: 50,
        child: Icon(
          item.iconData,
          color: widget.index == index
              ? ThemeData().primaryColor
              : AppColors.darkPink,
        ),
      ),
    );
  }

  List<Widget> _widgetsBuilder(
    List<CustomNavItem> items,
  ) {
    List<Widget> floatingNavBarItems = [];
    for (int i = 0; i < items.length; i++) {
      Widget item = this._customNavItem(
        items[i],
        i,
      );
      floatingNavBarItems.add(item);
    }
    return floatingNavBarItems;
  }

  _changePage(index) {
    _pageController.jumpToPage(index);
    setState(() {
      widget.index = index;
    });
  }
}

class CustomNavItem {
  IconData iconData;
  Widget page;
  CustomNavItem({
    @required this.iconData,
    @required this.page,
  });
}
