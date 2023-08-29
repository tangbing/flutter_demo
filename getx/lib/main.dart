import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/routes/routers.dart';

import 'counter/view.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteGet.main,
      getPages: RouteGet.getPages,
    );
  }
}

// class HomePage extends StatelessWidget {
//   var count = 0.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('getx')),
//       body: Center(
//         child: Column(
//           children: [
//              Obx(() => Text('${count}')),
//         ]
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _increment,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//
//   }
//
//   void _increment() {
//     count.value += 10;
//   }
// }

/*
class CounterController extends GetxController {
  int count = 0;
  
  void increment(){
    print("increment");
    count++;
    update();
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter111')),
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<CounterController>(
              /// 第一次使用某个 Controller 时需要进行初始化，
              /// 后续再使用同一个 Controller 就不需要再进行初始化，即不需要配置 init
                init: CounterController(), //Controller 首次初始化
                builder: (controller) {
              return Text('${controller?.count ?? 110}', style: TextStyle(fontSize: 50));
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

          ///使用 find 找到 Controller
          CounterController controller = Get.find();

          ///调用 Controller 方法
          controller.increment();
        },
      ),
    );
  }
}
*/
