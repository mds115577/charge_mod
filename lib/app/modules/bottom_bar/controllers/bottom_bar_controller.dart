

import 'package:get/get.dart';

final BottomBarController bottomBarController = Get.put(BottomBarController());

class BottomBarController extends GetxController {
  //TODO: Implement BottomBarController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  
}
