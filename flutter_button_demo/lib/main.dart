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
      home: const SwitchAndCheckBoxTestRoute(),
    );
  }
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  const SwitchAndCheckBoxTestRoute({Key? key}) : super(key: key);

  @override
  _SwitchAndCheckBoxTestRouteState createState() => _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true;  // 维护单选开光状态
  bool _checkboxSelected = true; // 维护复选开光状态
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Switch And CehckBox"),
      ),
      body: Column(
        children: [
          Expanded(child:
          Switch(value: _switchSelected,
              onChanged: (value) {
                setState(() {
                  _switchSelected = value;
                });
              }),
          ),
          Expanded(child:
          Checkbox(value: _checkboxSelected,
              activeColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value ?? true;
                });
              }),
          )
        ],
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

class MyIconFontPage extends StatelessWidget {

  const MyIconFontPage({Key? key}) : super(key: key);

  // String icons = "";
  // icons += "\uE03e";
  // icons += " \uE237";
  // icons += " \uE287";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.accessible, color: Colors.green),
          Icon(Icons.error, color: Colors.green),
          Icon(Icons.fingerprint, color: Colors.green),
        ],
      ),
    );
  }
}


class ImageAndIconRoute extends StatelessWidget {
  const ImageAndIconRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var img = AssetImage("imgs/avatar.png");
    return SingleChildScrollView(
      child: Column(
        children: [

          Image(image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.fill,
          ),

          Image(image: img,
            height: 50.0,
            width: 50.0,
            fit: BoxFit.contain,
          ),

          Image(image: img,
            height: 100.0,
            width: 50.0,
            fit: BoxFit.fitWidth,
          ),

          Image(image: img,
            height: 100.0,
            width: 50.0,
            fit: BoxFit.fitHeight,
          ),

          Image(image: img,
            height: 100.0,
            width: 50.0,
            fit: BoxFit.scaleDown,
          ),


          Image(image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.none,
          ),

          Image(image: img,
            width: 100.0,
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,
            fit: BoxFit.fill,
          ),

          Image(image: img,
            height: 100.0,
            width: 200.0,
            repeat: ImageRepeat.repeatY,
          )
        ].map((e){
          return Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 100,
                    child: e,
                  ),
              ),
              Text(e.fit.toString())
            ],
          );
        }).toList(),
      ),
    );
  }
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
             ElevatedButton.icon(
            icon: Icon(Icons.send),
             label: Text("发送"),
             onPressed: () {
                print("click ElevatedButton!");
            }
        ),

            TextButton(onPressed: () {
              print("click TextButton!");
            }, child: Text("TextButton")),

            OutlinedButton(onPressed: () {
              print("click OutlinedButton!");
            }, child: Text("OutlineButton")),

            Image(
              image: AssetImage("imgs/avatar.png"),
              width: 100.0
            ),

            Image.asset("imgs/avatar.png",
              width: 100.0,
            ),

            // Image(image: NetworkImage(
            //     "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"
            // ),
            //   width: 100.0),


            Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              width: 100.0
            )

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
