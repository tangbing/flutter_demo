import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo111',
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
      home: const SampleAppPage(),
    );
  }
}




class SampleGestureDetector extends StatelessWidget {
  const SampleGestureDetector({Key? key}) : super(key: key);

  // AnimationController? controller;
  // CurvedAnimation? curve;
  //
  // stat




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: FlutterLogo(
            size: 200.0,
          ),
          onTap: () {
            print("tap");
          },
          onLongPress: (){
            print("onLongPress");
          },
        ),
      ),
    );
  }
}



class SampleAppPage extends StatefulWidget {
  const SampleAppPage({Key? key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> with TickerProviderStateMixin {
  
  List widgets = [];
  
  AnimationController? controller;
  CurvedAnimation? curve;
  
  
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for(int i = 0; i< 100; i++){
    //   widgets.add(getRow(i));
    // }
    
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: RotationTransition(
            turns: curve!,
            child: FlutterLogo(
              size: 200.0,
            ),
          ),
          onDoubleTap: (){
            if (controller!.isCompleted) {
              controller!.reverse();
            } else {
              controller!.forward();
            }
          },
        ),
      ),
    );
    
    // return ListView.builder(
    //     itemCount: widgets.length,
    //     itemBuilder: (BuildContext context, int position){
    //       return getRow(position);
    //     });
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row $i"),
      ),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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

  List widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
               return getRow(position);
          });
    }
  }

  getProgressDialog() {
      return Center(child: CircularProgressIndicator());
  }

  Widget getRow(int i) {
    return Padding(padding: EdgeInsets.all(10), child: Text('Row ${widgets[i]['title']}'));
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(dataURL);
    setState(() {
      final result = jsonDecode(response.body);

      widgets = result;
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
        title: Text('Sample App'),
      ),
      body: getBody(),
    );
  }
}
