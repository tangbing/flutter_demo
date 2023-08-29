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
      home: Mytest(),
    );
  }
}

class Mytest extends StatefulWidget {
  @override
  _MytestState createState() => _MytestState();
}

class _MytestState extends State<Mytest> {
  var _dropValue = '2020';
  List _list = [
    {
      'id': '1',
      'num': '0',
      'cover':
      'https://daybili.oss-cn-beijing.aliyuncs.com/image/202008/1m.jpg',
      'name': '1月'
    },
    {
      'id': '1',
      'num': '0',
      'cover':
      'https://daybili.oss-cn-beijing.aliyuncs.com/image/202008/1m.jpg',
      'name': '1月'
    },
    {
      'id': '1',
      'num': '0',
      'cover':
      'https://daybili.oss-cn-beijing.aliyuncs.com/image/202008/1m.jpg',
      'name': '1月'
    },
    {
      'id': '1',
      'num': '0',
      'cover':
      'https://daybili.oss-cn-beijing.aliyuncs.com/image/202008/1m.jpg',
      'name': '1月'
    },
    {
      'id': '1',
      'num': '0',
      'cover':
      'https://daybili.oss-cn-beijing.aliyuncs.com/image/202008/1m.jpg',
      'name': '1月'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('备忘录' + _dropValue),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.date_range),
              tooltip: "编辑",
              onPressed: () {
                return bottomModal();
              },
            ),
          ],
        ), //这个是顶部tab样式，如果不需要可以去掉
        body: monthList());
  }

  //核心的内容列表数据
  Widget monthList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            return _itemGrid(index);
          },
          itemCount: _list.length,
        ),
      ),
    );
  }

  Widget _itemGrid(index) {
    return InkWell(
      child: Container(
        color: Colors.black,
        height: 120,
        padding: EdgeInsets.all(0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: 150,
              child: Image.network(
                _list[index]['cover'],
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <InlineSpan>[
                        TextSpan(
                          text: _list[index]['name'],
                          style: TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.none,
                              color: Colors.white),
                        ),
                        TextSpan(
                          text: '${index}' + '条',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              decoration: TextDecoration.none),
                        ),
                        TextSpan(
                          text: '提醒',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                      ]),
                ),
                decoration: BoxDecoration(color: Color(0x72000000)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //底部日期选择框
   bottomModal() {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context1, state) {
            ///这里的state就是setState
            return Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.close),
                      )),
                  selectYear(context1, state),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.done),
                      ))
                ],
              ),
            );
          });
        });
  }

  Widget selectYear(context1, state) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        iconSize: 20.0, //设置三角标icon的大小
        value: _dropValue,
        items: [
          DropdownMenuItem(
            child: Text('2020年'),
            value: '2020',
          ),
          DropdownMenuItem(child: Text('2021年'), value: '2021'),
          DropdownMenuItem(child: Text('2022年'), value: '2022'),
        ],
        onChanged: (value) {
          state(() {
            _dropValue = value as String;
          });
          setState(() {
            _dropValue = value as String;
          });
        },
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('margin 与 padding的区别'),),
      body: Container(
          // 圆角
          /// BoxDecoration 可以让你定义容器的装饰，包括背景颜色、边框、圆角和阴影等
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),  // 阴影颜色
                spreadRadius: 5,  // 阴影扩展半径
                blurRadius: 7,    // 阴影模糊半径
                offset: Offset(0, 3),  // 阴影偏移
              )
            ]
          ),

          margin: EdgeInsets.all(10), // 外边距，距离别的空间的间距
          padding: EdgeInsets.all(10), // 内边距，自己控件的碱韭
          child: Text(' Try running your application see the application has ablue toolbar. Then, without quitting the app, trychanging the primarySwatch below to Colors.green and then invokerestarted'),
      ),
    );
  }
}


class MyContent extends StatelessWidget {
  const MyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto Adjusting Container')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                Text('11111', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
