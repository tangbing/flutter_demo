import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        appBar: AppBar(title: const Text("Flow Page"),
        ),
        body: const AlignFactorDemo(),
      ),
    );
  }
}

/*
当widthFactor或heightFactor为null时组件的宽高将会占用尽可能多的空间
 */
class AlignFactorDemo extends StatelessWidget {
  const AlignFactorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text("xxx"),
              ),
          ),

          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text("xxx"),
            ),
          )
        ],
      ),
    );
  }
}


class AlignLayoutPage extends StatelessWidget {
  const AlignLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120.0,
      // width: 120.0,
      color: Colors.blue.shade50,
      child: Align(
        widthFactor: 2,
        heightFactor: 2,
        alignment: FractionalOffset(0.5, 0.5),
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}


/*
由于第二个子文本组件没有定位，所以fit属性会对它起作用，就会占满Stack。
由于Stack子元素是堆叠的，所以第一个子文本组件被第二个遮住了，而第三个在最上层，所以可以正常显示。
 */
class StackPositionFitModelPage extends StatelessWidget {
  const StackPositionFitModelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,// 指定未定位或部分定位widget的对齐方式
        children: [
          Positioned(child: Text("I am Jack"),
            left: 18.0,
          ),
          Container(
            child: Text("Hello world", style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),

          Positioned(child: Text("Your friend"),
            top: 18.0,
          ),
        ],
      ),
    );
  }
}


class StackPositionPage extends StatelessWidget {
  const StackPositionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, // 指定未定位或部分定位widget的对齐方式
          children: [
            Container(
              child: Text("Hello world", style: TextStyle(color: Colors.white)),
              color: Colors.red,
            ),

            Positioned(child: Text("I am Jack"),
                      left: 18.0,
            ),
            Positioned(child: Text("Your friend"),
              top: 18.0,
            ),
          ],
        ),
    );
  }
}


class MyFlowPage extends StatelessWidget {
  const MyFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
           children: [
             Container(width: 80.0, height: 80.0, color: Colors.red),
             Container(width: 80.0, height: 80.0, color: Colors.green),
             Container(width: 80.0, height: 80.0, color: Colors.blue),
             Container(width: 80.0, height: 80.0, color: Colors.yellow),
             Container(width: 80.0, height: 80.0, color: Colors.brown),
             Container(width: 80.0, height: 80.0, color: Colors.purple)
           ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});
  
  @override
  void paintChildren(FlowPaintingContext context) {
     var x = margin.left;
     var y = margin.top;
     // 计算每一个子width的位置
     for (int i = 0; i < context.childCount; i++) {
       var w = context.getChildSize(i)!.width + x + margin.right;
       if (w < context.size.width) {
         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
         x = w + margin.left;
       } else {
         x = margin.left;
         y += context.getChildSize(i)!.height + margin.top + margin.bottom;
         // 绘制子width
         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
         x += context.getChildSize(i)!.width + margin.left + margin.right;
       }
     }
  }
  
  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Wrap(
           spacing: 18.0, // 主轴（水平）方向间距
           runSpacing: 14.0, // 纵轴（垂直）方向间距
           alignment: WrapAlignment.center, //沿主轴方向居中
           children: [
             Chip(
                 avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("A")),
                 label: Text("Hamilton"),
             ),
             Chip(
                 avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("M")),
                 label: Text("Lafayette"),
             ),
             Chip(avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("H")),
                 label: Text("Mulligan"),
             ),
             Chip(avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("J")),
                 label: Text("Laurens"))
           ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
