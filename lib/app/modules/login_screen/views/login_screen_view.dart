import 'package:charge_mod/colors/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({Key? key}) : super(key: key);
  @override
  final LoginScreenController controller = Get.put(LoginScreenController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // Check if the brightness is dark
    bool isDarkTheme = themeData.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkTheme ? primaryTextColor : whiteColor,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 7),
            child: Column(
              children: [
                Text(
                  "ChargeMOD",
                  style: GoogleFonts.poppins(
                      color: isDarkTheme ? whiteColor : primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Let’s Start",
                  style: GoogleFonts.poppins(
                      color: isDarkTheme ? whiteColor : primaryTextColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "From login",
                  style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 41),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: controller.mobileNumberEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        textAlignVertical: TextAlignVertical.top,
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: primaryTextColor),
                        decoration: InputDecoration(
                            fillColor: whiteColor,
                            filled: true,
                            hintText: "Enter phone number",
                            hintStyle:
                                const TextStyle(color: secondaryTextColor),
                            icon: InkWell(
                              onTap: () {
                                controller.openCountryPicker();
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(
                                        color: borderColorForLoginTextField),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GetBuilder<LoginScreenController>(
                                          builder: (contexts) {
                                        return Wrap(
                                          children: [
                                            contexts.selectedCountry == null
                                                ? Image.asset(
                                                    "assets/login/flag.png")
                                                : Text(
                                                    contexts.selectedCountry!
                                                        .flagEmoji,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: primaryTextColor,
                                            )
                                          ],
                                        );
                                      })),
                                ),
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 40),
                            prefixIcon: SvgPicture.asset(
                              "assets/login/call_icon.svg",
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: borderColorForLoginTextField),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9))),
                            enabled: true,
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9))),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 228, 223, 223)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9))),
                            contentPadding:
                                const EdgeInsets.only(left: 30, top: 0),
                            border: const OutlineInputBorder()),
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            controller.generateOtp(controller);
                          }
                        },
                        validator: (value) {
                          if (!RegExp(r"^\d{10}$").hasMatch(value!) ||
                              value.length < 3) {
                            return 'Please enter valid number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Obx(() {
                  return ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(100.w, 45)),
                          backgroundColor:
                              const MaterialStatePropertyAll(primaryColor),
                          shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))))),
                      onPressed: controller.isOtpLoading.value
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                controller.generateOtp(controller);
                              }
                            },
                      child: controller.isOtpLoading.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: whiteColor,
                                ),
                                Text(" Processing",
                                    style: GoogleFonts.poppins(
                                        color: whiteColor, fontSize: 16))
                              ],
                            )
                          : Text(
                              "Sent OTP",
                              style: GoogleFonts.poppins(
                                  color: whiteColor, fontSize: 16),
                            ));
                })
              ],
            ),
          )
          // InkWell(
          //   onTap: () {
          //     controller.openCountryPicker();
          //   },
          //   child: Text(
          //     controller.selectedCountry.flagEmoji,
          //     style: const TextStyle(fontSize: 16.0),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            HtmlWidget(
              '''<center><p>By Continuing you agree to our <br> <span style="color:rgba(230, 116, 12, 1)">Terms & Condition</span> and <span style="color:rgba(230, 116, 12, 1)">Privacy Policy</Span></p></center>''',
              textStyle: GoogleFonts.aBeeZee(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
