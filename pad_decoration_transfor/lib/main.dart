import 'package:flutter/material.dart';
import 'dart:math' as math;


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
        appBar: AppBar(title: Text("Padding decoration transform container Demo")),
        body: const ContainerRoute(),
      ),
    );
  }
}

// Padding
class PaddingTestRoute extends StatelessWidget {
  const PaddingTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(left: 8),
            child: Text("Hello world"),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("Hello world"),
          ),
          Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text("Hello world"),
          ),
        ],
      ),
    );
  }
}

// decorationedBox
class DecorationedBoxRoute extends StatelessWidget {
  const DecorationedBoxRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red,Colors.orange.shade700]), //背景渐变
          borderRadius: BorderRadius.circular(3.0), //3像素圆角
          boxShadow: [ //阴影
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18.0),
          child: Text("Login", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class ContainerRoute extends StatelessWidget {
  const ContainerRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 120.0),
      constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),//卡片大小
      decoration: BoxDecoration( //背景装饰
        gradient: RadialGradient( //背景径向渐变
          colors: [Colors.red, Colors.orange],
          center: Alignment.topLeft,
          radius: .98,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      transform: Matrix4.rotationZ(.2),
      alignment: Alignment.center,
      child: Text(
        "5.20", style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}


class TranslateRoute extends StatelessWidget {
  const TranslateRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(30, 70, 0, 0),
      child:  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: Matrix4.skewY(0.3), //沿Y轴斜斜0.3弧度
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: Text("Apartment for rent!"),
                ),
              ),
            ),

            SizedBox(height: 100),

            //默认原点为左上角, x轴正数child往右边，y轴正数child往上边
            DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.translate(offset: Offset(-30.0, 20),
                  child: Text("Hello world"),
                ),
            ),
            SizedBox(height: 100),

            DecoratedBox(decoration: BoxDecoration(color: Colors.red),
              child: Transform.rotate(angle: math.pi/2,
                child: Text("Hello world"),
              ),
            ),
            Text("你好", style: TextStyle(color: Colors.green, fontSize:  18.0)),


            SizedBox(height: 100),
            DecoratedBox(decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                scale: 1.5,
                child: Text("Hello world"),
              ),
            ),

            /*
            由于第一个Text应用变换(放大)后，
            其在绘制时会放大，但其占用的空间依然为红色部分，所以第二个Text会紧挨着红色部分，最终就会出现文字重合。

            由于矩阵变化只会作用在绘制阶段，所以在某些场景下，
            在UI需要变化时，可以直接通过矩阵变化来达到视觉上的UI改变，
            而不需要去重新触发build流程，这样会节省layout的开销，所以性能会比较好。
            如之前介绍的Flow组件，它内部就是用矩阵变换来更新UI，除此之外，Flutter的动画组件中也大量使用了Transform以提高性能。
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(scale: 1.2,
                    child: Text("Hello world"),
                  ),
                ),
                Text("你好", style: TextStyle(color: Colors.green, fontSize:  18.0))
              ],
            ),

            SizedBox(height: 100),

            /*
            由于RotatedBox是作用于layout阶段，所以子组件会旋转90度（而不只是绘制的内容）
            ，decoration会作用到子组件所占用的实际空间上，所以最终就是上图的效果
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text("你好", style: TextStyle(color: Colors.green, fontSize:  18.0))
              ],
            )

          ],
        ),
      ),
    );
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
