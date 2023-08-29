import 'package:get/get.dart';

import '../counter/logic.dart';


class TwoLogic extends GetxController {
  String passParamets = '';

  @override
  void onInit() {
    super.onInit();
    passParamets = Get.arguments['name'];
    print("passParamets: ${passParamets}");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    // String nameStr = Get.arguments['name'];
    // print("nameStr: ${nameStr}");
    super.onReady();
    CounterLogic result = Get.find<CounterLogic>();
    if (result != null) {
      result.state.count.value = 10086;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}
