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
      home: const MyListView(),
    );
  }
}


class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);
  @override
  MyListViewState createState() => MyListViewState();

}

class MyListViewState extends State {
  final _fontStyle = const TextStyle(fontSize: 15);

  final _titles = ['11','22','33','44','55','66','77','88','99','10'];
  List<String> _indexs = [];


  @override
  Widget build(BuildContext context) {

    createData();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('customListView') ,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _indexs.length,
            itemBuilder: (context, i){
           return ListTile(
             title: Text(
               _indexs[i],
               style: _fontStyle,
             ),
           );
        }),
      ),
    );
  }


  void createData(){
    for (int i=0; i<100; i++) {
        var numStr = i.toString();
        _indexs.add(numStr);
        print(numStr);
    }
  }


}