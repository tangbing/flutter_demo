import 'package:get/get.dart';

import 'logic.dart';

class TwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TwoLogic());
  }
}
