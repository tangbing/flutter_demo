import 'package:get/get.dart';

import 'logic.dart';
/// 用于懒加载对应的Controller
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CounterLogic());
  }

}
