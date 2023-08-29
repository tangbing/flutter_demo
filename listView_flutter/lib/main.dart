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
      home: Scaffold(
        appBar: AppBar(
          title: Text("listView的演练"),
        ),
        body: MyScrollViewListener(),
      ),
    );
  }
}


class MyScrollViewListener extends StatefulWidget {
  const MyScrollViewListener({Key? key}) : super(key: key);

  @override
  _MyScrollViewListenerState createState() => _MyScrollViewListenerState();
}

class _MyScrollViewListenerState extends State<MyScrollViewListener> {
  late ScrollController _controller;
  bool _isShowTap = false;


  @override
  void initState() {
    // TODO: implement initState

    _controller = ScrollController();

    _controller!.addListener(() {
      var tempShowTop = _controller!.offset >= 100;
      if (tempShowTop != _isShowTap) {
        setState(() {
          _isShowTap = tempShowTop;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView展示，监听滚动，点击按钮滚动到底部"),
      ),
      body: ListView.builder(
        itemCount: 100,
          itemExtent: 60,
          itemBuilder: (BuildContext context, int index){
            return ListTile(title: Text("item$index"));
          }),
      floatingActionButton: !true ? null : FloatingActionButton(
         child: Icon(Icons.arrow_upward),
          onPressed: (){
            _controller!.animateTo(0.0, duration: Duration(milliseconds: 1000), curve: Curves.ease);
          }),
    );
  }
}



class CustomSlivers extends StatelessWidget {
 // const CustomSlivers({Key? key}) : super(key: key)
  

  @override
  Widget build(BuildContext context) {
    return showCustomScrollView();
  }

  Widget showCustomScrollView() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('tb Demo'),
            background: Image(
              image: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 10
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3.0 // 子widget的宽高比
            )),

        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20
            ),
            itemExtent: 50)
      ],
    );
  }


}



class SliversDemo extends StatelessWidget {
  const SliversDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment(0,0),
                        color: Colors.orange,
                        child: Text("item:$index"),
                      );
                    },
                  childCount: 20
                ),
              ),
            ))
      ],
    );
  }
}



class MyCirdBuilderCreate extends StatelessWidget {
  const MyCirdBuilderCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
           padding: EdgeInsets.all(8),
            color: Colors.blue,
            child: Text("index:$index"),

          );
        });
  }
}




class MyGridCountDemo extends StatelessWidget {
  const MyGridCountDemo({Key? key}) : super(key: key);

  List<Widget> getGridViewWidgets() {
    return List.generate(100, (index) {
      return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("item$index", style: TextStyle(fontSize: 20, color: Colors.white)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
       // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       //    crossAxisCount: 3,
       //    mainAxisSpacing: 30,
       //    crossAxisSpacing: 10,
       //    childAspectRatio: 1.0
       //  ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        mainAxisSpacing: 30,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
      ),
      children: getGridViewWidgets(),
    );
  }
}



class MyListViewCreateBuilder extends StatelessWidget {
  //const MyListViewCreateBuilder({Key? key}) : super(key: key);

  Divider blueColor = Divider(color: Colors.blue);
  Divider redColor  = Divider(color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
         itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("标题$index"),subtitle: Text("详情内容$index",), leading: Icon(Icons.people, size: 36,),);
        },
      separatorBuilder: (BuildContext context, int index) {
           return index % 2 == 0 ? redColor : blueColor;
      },
    );
  }
}



class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 200,
        children: [
          Container(color: Colors.red,width: 200,),
          Container(color: Colors.orange,width: 200,),
          Container(color: Colors.blueAccent,width: 200,),
          Container(color: Colors.yellow,width: 200,),
          Container(color: Colors.purple,width: 200,),

        ],
    );
  }
}
