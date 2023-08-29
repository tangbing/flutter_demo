
import 'package:beauty_flutter/content_pager.dart';
import 'package:flutter/material.dart';

///底部导航栏框架搭建
class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final _defaultColor = Colors.grey;
  final _activeColor  = Colors.blue;

  int _selectIndex = 0;
  final ContentPagerController _contentPagerController = ContentPagerController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
             gradient: LinearGradient(
               colors: [
                 Color(0xffedeef0),
                 Color(0xffe6e7e9)
               ],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter
             )
          ),
        child: Center(
          // pageView回调，给BottomNavigationBar
          child: ContentPager(onPageChanged: (int index){
            setState(() {
              _selectIndex = index;
            },);

          }, contentPagerController: _contentPagerController,)
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        items: [
        _bottomNavigItem("本周", Icons.folder, 0),
        _bottomNavigItem("分享", Icons.explore, 1),
        _bottomNavigItem("免费", Icons.donut_small, 2),
        _bottomNavigItem("长安", Icons.person, 3),
      ],
        onTap: (index) {
          _contentPagerController.jumpToPage(index);
          // 修改状态
          setState(() {
            _selectIndex = index;
          });
        },
      ),
    );
  }

  _bottomNavigItem(String title, IconData icon, int index) {
     return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
      title: Text(title, style: TextStyle(color: _selectIndex == index ? _activeColor : _defaultColor))
    );
  }
}
