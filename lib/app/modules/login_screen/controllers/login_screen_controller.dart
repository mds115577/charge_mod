import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charge_mod/app/data/api_services.dart';
import 'package:charge_mod/app/data/refresh_token/refresh_token/refresh_toke.dart';
import 'package:charge_mod/app/modules/bottom_bar/views/bottom_bar_view.dart';
import 'package:charge_mod/app/modules/login_screen/model/user_details_model.dart';
import 'package:charge_mod/app/modules/otp/model/otp_verify_response_model.dart';
import 'package:charge_mod/app/modules/otp/views/otp_view.dart';
import 'package:charge_mod/app/modules/update_profile/views/update_profile_view.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

class LoginScreenController extends GetxController {
  //TODO: Implement LoginScreenController

  final count = 0.obs;

  void increment() => count.value++;

  final TextEditingController mobileNumberEditingController =
      TextEditingController();
  var isOtpLoading = false.obs;
  var isOtpVerifying = false.obs;
  Country? selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "9123456789",
      displayName: "India (IN) [+91]",
      displayNameNoCountryCode: "India (IN)",
      e164Key: "91-IN-0");

  final defaultPinTheme = PinTheme(
    width: 55,
    height: 55,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColorForLoginTextField),
    ),
  );

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  Timer? timer;
  RxInt start = 59.obs;

  void openCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      onSelect: (Country country) {
        selectedCountry = country;

        update();
      },
      showPhoneCode: true,
    );
  }

  void startTimer() {
    start.value = 59;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  generateOtp(loginScreenController) async {
    try {
      isOtpLoading.value = true;

      final body = {"mobile": mobileNumberEditingController.text.toString()};
      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/signIn"),
          body: jsonEncode(body),
          headers: ApiService().headers);
      log(response.statusCode.toString());

      if (response.statusCode > 199 && response.statusCode < 300) {
        isOtpLoading.value = false;
        startTimer();
        Get.to(OtpView(
          mobileNumber: mobileNumberEditingController.text.toString(),
          loginScreenController: loginScreenController,
        ));

        AnimatedSnackBar.rectangle(
          'Success',
          'Otp Sent Successfully',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      } else {
        isOtpLoading.value = false;
        AnimatedSnackBar.rectangle(
          'Success',
          'Something went wrong',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  resendeOtp() async {
    try {
      final body = {
        "mobile": mobileNumberEditingController.text.toString(),
        "type": "text"
      };
      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/resend"),
          body: jsonEncode(body),
          headers: ApiService().headers);
      log(response.body.toString());

      if (response.statusCode > 199 && response.statusCode < 300) {
        startTimer();
        pinController.clear();
        AnimatedSnackBar.rectangle(
          'Success',
          'Otp resend Successfully',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      } else {
        isOtpLoading.value = false;
        AnimatedSnackBar.rectangle(
          'Error',
          'Something went wrong',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  verifyOtp() async {
    try {
      const prefs = FlutterSecureStorage();

      final body = {
        "mobile": mobileNumberEditingController.text,
        "otp": pinController.text
      };
      isOtpVerifying.value = true;
      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/verify"),
          body: jsonEncode(body),
          headers: ApiService().headers);
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode > 199 && response.statusCode < 300) {
        final verifyOtpResponseModel =
            verifyOtpResponseModelFromJson(response.body);
        await prefs.write(
            key: 'userId',
            value: verifyOtpResponseModel.data.userId.toString());
        await prefs.write(
            key: 'refreshToken',
            value: verifyOtpResponseModel.data.refreshToken.toString());
        await prefs.write(
            key: 'accesshToken',
            value: verifyOtpResponseModel.data.accessToken.toString());
        await prefs.write(
            key: 'mobileNumber',
            value: mobileNumberEditingController.text.toString());
        AnimatedSnackBar.rectangle(
          'Success',
          'Otp verified Successfully',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
        UserDetailsModel? data = await getUserDetails();
        isOtpVerifying.value = false;

        if (data == null ||
            data.data.user.first.firstName == null ||
            data.data.user.first.lastName == null ||
            data.data.user.first.email == null) {
          Get.offAll(UpdateProfileView(
            mobileNumber: mobileNumberEditingController.text,
          ));
        } else {
          Get.offAll(const BottomBarView());
        }
      } else {
        isOtpVerifying.value = false;
        AnimatedSnackBar.rectangle(
          'Error',
          'Something went wrong',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getUserDetails() async {
    try {
      const prefs = FlutterSecureStorage();
      await RefreshToken().refreshToken();
      final token = await prefs.read(key: 'accessToken');
      log(token.toString());
      final response = await http.get(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/get-customer"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      log(response.body);
      if (response.statusCode == 200) {
        final userDetailsModel = userDetailsModelFromJson(response.body);

        return userDetailsModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
