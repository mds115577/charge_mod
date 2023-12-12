import 'package:charge_mod/app/modules/login_screen/views/login_screen_view.dart';
import 'package:charge_mod/app/modules/on_boarding/controllers/on_boarding_controller.dart';
import 'package:charge_mod/app/modules/on_boarding/views/on_boarding_view3.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingView2 extends GetView<OnBoardingController> {
  const OnBoardingView2({super.key});

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
                    "Easy EV Navigation",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Travel Route",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "For Electrics",
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SvgPicture.asset(
              isDarkTheme
                  ? "assets/on_board/routemap_dark.svg"
                  : 'assets/on_board/routemap.svg', // Replace with your image URL

              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Grab The Best In Class \nDigital Experience Crafted For\nEV Drivers",
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
                  ? "assets/on_board/indicator_2_dark.svg"
                  : "assets/on_board/indicator_page_2.svg"),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                backgroundColor: primaryColor,
                heroTag: "2",
                onPressed: () {
                  Get.to(const OnBoardingView3());
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
