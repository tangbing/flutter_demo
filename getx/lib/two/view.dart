import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TwoPage extends StatelessWidget {
  TwoPage({Key? key}) : super(key: key);

  final logic = Get.find<TwoLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaaa'),
      ),
      body: Center(
        child: Container(color: Colors.red,
          child: Center(
            child: Text('${logic.passParamets}'),
          ),
        ),
      ),
    );
  }
}


