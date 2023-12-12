import 'dart:developer';

import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);
  final SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // Check if the brightness is dark
    bool isDarkTheme = themeData.brightness == Brightness.dark;
    log(isDarkTheme.toString());
    return Scaffold(
      backgroundColor: isDarkTheme ? primaryTextColor : whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
            isDarkTheme
                ? "assets/splash_screen/spash_screen_logo_dark.svg"
                : "assets/splash_screen/spash_screen_logo_light.svg",
          ))
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7),
              child: Obx(() {
                return LinearProgressIndicator(
                  minHeight: 6,
                  color: primaryColor,
                  value: splashScreenController.progress.value,
                );
              }),
            ),
            Text(
              "Connecting to chargeMOD",
              style: GoogleFonts.poppins(
                  color: isDarkTheme ? whiteColor : secondaryTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
