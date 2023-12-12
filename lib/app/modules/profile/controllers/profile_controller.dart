import 'dart:convert';
import 'dart:developer';

import 'package:charge_mod/app/data/api_services.dart';
import 'package:charge_mod/app/modules/bottom_bar/views/bottom_bar_view.dart';
import 'package:charge_mod/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:charge_mod/app/modules/login_screen/model/user_details_model.dart';
import 'package:charge_mod/app/modules/login_screen/views/login_screen_view.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../data/refresh_token/refresh_token/refresh_toke.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  void increment() => count.value++;

  RxString firstName = "".obs;
  RxString lastName = "".obs;
  getUserData() async {
    try {
      UserDetailsModel? userDetailsModel =
          await LoginScreenController().getUserDetails();
      if (userDetailsModel != null) {
        firstName.value = userDetailsModel.data.user.first.firstName;
        lastName.value = userDetailsModel.data.user.first.lastName;
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  logOut() async {
    try {
      const prefs = FlutterSecureStorage();
      await RefreshToken().refreshToken();
      final token = await prefs.read(key: 'accessToken');
      final body = {"refreshToken": "$token"};

      islogOutLoading.value = true;

      log(token.toString());
      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/logout"),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      log(response.body.toString());
      if (response.statusCode == 200) {
        await prefs.deleteAll();

        Get.offAll(LoginScreenView());
        BottomBarView.selectedPageIndex.value = 0;
        islogOutLoading.value = false;
      } else {
        islogOutLoading.value = false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  var islogOutLoading = false.obs;
  dialogPopForAccountDeletion(
    context,
  ) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Warning",
      titleStyle: GoogleFonts.poppins(
          color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 18),
      content: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Are you sure?'",
            style: GoogleFonts.roboto(
                color: const Color.fromARGB(255, 120, 118, 118), fontSize: 16),
          ),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      confirm: Obx(() {
        return ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(secondaryTextColor),
                elevation: MaterialStateProperty.all(0)),
            onPressed: islogOutLoading.value == true
                ? null
                : () async {
                    await logOut();
                  },
            child: islogOutLoading.value == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Processing",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                : Text("Yes",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)));
      }),
      cancel: Obx(() {
        return Visibility(
          visible: islogOutLoading.value == true ? false : true,
          child: ElevatedButton(
              style: ButtonStyle(
                  // fixedSize: MaterialStateProperty.all(Size(110, 40)),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  elevation: MaterialStateProperty.all(0)),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "No",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        );
      }),
    );
  }
}
