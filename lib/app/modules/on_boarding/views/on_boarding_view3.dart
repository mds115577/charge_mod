import 'package:charge_mod/app/modules/login_screen/views/login_screen_view.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView3 extends GetView<OnBoardingController> {
  const OnBoardingView3({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // Check if the brightness is dark
    bool isDarkTheme = themeData.brightness == Brightness.dark;

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: isDarkTheme ? primaryTextColor : whiteColor,
          image: const DecorationImage(
              image: AssetImage("assets/on_board/background_lines.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.offAll(LoginScreenView());
                    },
                    child: Text(
                      "SKIP",
                      style: GoogleFonts.poppins(
                          color: isDarkTheme ? whiteColor : primaryTextColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 14.h, bottom: 7),
              child: Column(
                children: [
                  Text(
                    "Interaction with Grid",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "RealTime",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Monitoring",
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/on_board/charger.png', // Replace with your image URL
              width: 250, height: 262,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Intelligent Sensible Devices\nAmbicharge Series",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                )
              ],
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: primaryColor,
                heroTag: "1",
                onPressed: () {
                  Get.back();
                },
                shape: const StadiumBorder(),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: whiteColor,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              SvgPicture.asset(isDarkTheme
                  ? "assets/on_board/indicator_3_dark.svg"
                  : "assets/on_board/indicator_page_3.svg"),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                backgroundColor: primaryColor,
                heroTag: "2",
                onPressed: () {
                  Get.offAll(LoginScreenView());
                },
                shape: const StadiumBorder(),
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
