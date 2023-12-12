import 'package:charge_mod/app/modules/login_screen/controllers/login_screen_controller.dart';

import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView(
      {Key? key,
      required this.mobileNumber,
      required this.loginScreenController})
      : super(key: key);
  final String mobileNumber;
  final LoginScreenController loginScreenController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // Check if the brightness is dark
    bool isDarkTheme = themeData.brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDarkTheme ? primaryTextColor : whiteColor,
        appBar: AppBar(
          backgroundColor: isDarkTheme ? primaryTextColor : whiteColor,
          leading: Container(),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              AppBar(
                backgroundColor: isDarkTheme ? primaryTextColor : whiteColor,
                centerTitle: true,
                title: Text(
                  "Verification",
                  style: GoogleFonts.aBeeZee(
                      color: isDarkTheme ? whiteColor : primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 43,
              ),
              Text(
                  "We’ve send you the verification \n code on +91 $mobileNumber",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                      color: isDarkTheme ? whiteColor : primaryTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 43,
              ),
              Pinput(
                controller: loginScreenController.pinController,
                focusNode: loginScreenController.focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: false,
                defaultPinTheme: loginScreenController.defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                // validator: (value) {
                //   return value == '2222' ? null : 'Pin is incorrect';
                // },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                  loginScreenController.verifyOtp();
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: primaryTextColor,
                    ),
                  ],
                ),
                focusedPinTheme: loginScreenController.defaultPinTheme.copyWith(
                  decoration: loginScreenController.defaultPinTheme.decoration!
                      .copyWith(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryTextColor),
                  ),
                ),
                submittedPinTheme:
                    loginScreenController.defaultPinTheme.copyWith(
                  decoration: loginScreenController.defaultPinTheme.decoration!
                      .copyWith(
                    color: isDarkTheme ? whiteColor : fillColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColorForLoginTextField),
                  ),
                ),
                errorPinTheme:
                    loginScreenController.defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return loginScreenController.start.value == 0
                    ? TextButton(
                        onPressed: () {
                          loginScreenController.resendeOtp();
                        },
                        child: Text(
                          "Resend OTP",
                          style: GoogleFonts.poppins(color: primaryColor),
                        ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Re-send code in ",
                              style: GoogleFonts.poppins(
                                  color: isDarkTheme
                                      ? whiteColor
                                      : primaryTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                          Obx(() {
                            return Text(
                                "0:${loginScreenController.start.value.toString()}",
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400));
                          })
                        ],
                      );
              }),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  return ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(70.w, 43)),
                          backgroundColor:
                              const MaterialStatePropertyAll(primaryColor),
                          shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))))),
                      onPressed: loginScreenController.isOtpVerifying.value
                          ? null
                          : () {
                              loginScreenController.verifyOtp();
                            },
                      child: loginScreenController.isOtpVerifying.value
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
                              "CONTINUE",
                              style: GoogleFonts.poppins(
                                  color: whiteColor, fontSize: 16),
                            ));
                }),
              )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        )));
  }
}
