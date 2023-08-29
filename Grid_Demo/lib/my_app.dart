
import 'package:flutter/material.dart';

class MyGridApp extends StatelessWidget {
  const MyGridApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
            crossAxisCount: 2,
          children: [
            List.generate(100, (index) => {
               Center(
                child: Text("Item$index",style: Theme.of(context).textTheme.headline5,),
        );
            });
          ],
        ),
      ),
    );
  }
}

