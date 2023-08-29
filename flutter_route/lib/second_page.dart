

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route/ToDo.dart';

class SecondPage extends StatelessWidget {
  
  //final ToDo? todo;

  //const SecondPage({Key, this.todo?, required this.todo}) : super(key: key);

  //const SecondPage(this.todo, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final pushData = ModalRoute.of(context)?.settings.arguments as ToDo;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('push data: ${pushData.data}'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '返回数据');
                },
                child: Text("second page pop"))
          ],
        ),
      ),
    );
  }
}