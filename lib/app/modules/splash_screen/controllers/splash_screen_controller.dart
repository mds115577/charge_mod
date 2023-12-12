import 'dart:async';
import 'dart:developer';

import 'package:charge_mod/app/modules/bottom_bar/views/bottom_bar_view.dart';
import 'package:charge_mod/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:charge_mod/app/modules/login_screen/model/user_details_model.dart';
import 'package:charge_mod/app/modules/on_boarding/views/on_boarding_view1.dart';
import 'package:charge_mod/app/modules/update_profile/views/update_profile_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;
  @override
  void onInit() {
    _updateProgress();
    super.onInit();
  }

  void increment() => count.value++;
  final RxDouble progress = 0.0.obs;
  // Update progress every 100 milliseconds for a total duration of 5 seconds
  _updateProgress() async {
    try {
      const totalDuration = 3000; // 5 seconds in milliseconds
      const updateInterval = 100; // Update every 100 milliseconds

      int steps = totalDuration ~/ updateInterval;
      int currentStep = 0;

      const storage = FlutterSecureStorage();

// Read value
      final userId = await storage.read(key: 'userId');
      final mobileNumber = await storage.read(key: 'mobileNumber');
      log(userId.toString());
      Timer.periodic(const Duration(milliseconds: updateInterval),
          (timer) async {
        progress.value = currentStep / steps;

        currentStep++;

        if (currentStep > steps) {
          timer.cancel();
          if (userId == null) {
            Get.offAll(const OnBoardingView1());
            return;
          }

          UserDetailsModel? userData =
              await LoginScreenController().getUserDetails();
          if (userData != null &&
              (userData.data.user.first.firstName == null ||
                  userData.data.user.first.lastName == null ||
                  userData.data.user.first.email == null)) {
            Get.offAll(UpdateProfileView(mobileNumber: mobileNumber!));
          } else {
            Get.offAll(const BottomBarView());
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
