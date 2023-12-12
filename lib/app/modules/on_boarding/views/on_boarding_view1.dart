import 'package:charge_mod/app/modules/login_screen/views/login_screen_view.dart';
import 'package:charge_mod/app/modules/on_boarding/views/on_boarding_view2.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView1 extends GetView<OnBoardingController> {
  const OnBoardingView1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // Check if the brightness is dark
    bool isDarkTheme = themeData.brightness == Brightness.dark;
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
                    "Charge your EV",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "At Your",
                    style: GoogleFonts.poppins(
                        color: isDarkTheme ? whiteColor : primaryTextColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Fingertips",
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Transform.translate(
              offset:
                  Offset(-24.w, 0), // Adjust the horizontal offset as needed
              child: SvgPicture.asset(
                isDarkTheme
                    ? "assets/on_board/charging_scooter_dark.svg"
                    : 'assets/on_board/charging_scooter.svg', // Replace with your image URL
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Scan Charge and Go \nEffortless Charging schemas",
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
            children: [
              SizedBox(
                width: 40.w,
              ),
              SvgPicture.asset(isDarkTheme
                  ? "assets/on_board/indicator_1_dark.svg"
                  : "assets/on_board/indicator_page_1.svg"),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  Get.to(const OnBoardingView2());
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
