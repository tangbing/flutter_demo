import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const WeChatPage(),
    );
  }
}


class WeChatPage extends StatefulWidget {
  const WeChatPage({Key? key}) : super(key: key);

  @override
  _WeChatPageState createState() => _WeChatPageState();
}

class _WeChatPageState extends State<WeChatPage> {

  var _currentIndex = 0;


  List<Widget> pages = [
    Scaffold(
    appBar: AppBar(
      title: Text('微信'),
    ),
    body: Center(
      child: Text('微信主页'),
    ),
  ),

    Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
      ),
      body: Center(
        child: Text('通讯录列表'),
      ),
    ),

    Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Center(
        child: Text('发现列表'),
      ),
    ),

    Scaffold(
      appBar: AppBar(
        title: Text('我'),
      ),
      body: Center(
        child: Text('我的页面'),
      ),
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            print('select ${index}');

            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
                label: '微信'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: '通讯录'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: '发现'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: '我')
        ],
        ),
        body: pages[_currentIndex],
      ),
    );
  }
}



class ContentPager extends StatefulWidget {
  const ContentPager({Key? key}) : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
