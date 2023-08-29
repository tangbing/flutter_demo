import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/routes/routers.dart';

import 'logic.dart';

/// 界面控件，主要进行界面开发
class CounterPage extends GetWidget<CounterLogic> {
  CounterPage({Key? key}) : super(key: key);

  // final logic = Get.find<CounterLogic>();
  // final state = Get
  //     .find<CounterLogic>()
  //     .state;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CounterLogic>(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(title: Text('${controller.state.count}')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return Text('click ${controller.state.count.value}');
                  }) ,
                  ElevatedButton(
                    onPressed: () {
                      controller.increment();
                    },
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('push next page');
                     // Get.toNamed(RouteGet.two);
                     var result = Get.toNamed(RouteGet.two, arguments: {'name' : 'tbsss'});
                     print('result: ${result}');
                    },
                    child: const Text('push to Two page!'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
