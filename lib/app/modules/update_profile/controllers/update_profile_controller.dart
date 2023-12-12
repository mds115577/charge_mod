import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charge_mod/app/data/api_services.dart';
import 'package:charge_mod/app/modules/bottom_bar/views/bottom_bar_view.dart';
import 'package:charge_mod/app/modules/update_profile/model/user_register_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateProfileController extends GetxController {
  //TODO: Implement UpdateProfileController

  final count = 0.obs;

  void increment() => count.value++;

  final TextEditingController firstNameEditingController =
      TextEditingController();

  final TextEditingController lastNameEditingController =
      TextEditingController();

  final TextEditingController emailEditingController = TextEditingController();
  var isRegisterLoading = false.obs;

  registerUserDetails(mobile) async {
    try {
      isRegisterLoading.value = true;
      final body = {
        "mobile": mobile,
        "firstName": firstNameEditingController.text,
        "lastName": lastNameEditingController.text,
        "email": emailEditingController.text
      };

      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/register"),
          body: jsonEncode(body),
          headers: ApiService().headers);
      log(response.statusCode.toString());
      // log(response.body);
      if (response.statusCode > 199 && response.statusCode < 300) {
        final userRegisterResponseModel =
            userRegisterResponseModelFromJson(response.body);
        log(userRegisterResponseModel.refreshToken.length.toString());
        isRegisterLoading.value = false;
        Get.offAll(const BottomBarView());
        AnimatedSnackBar.rectangle(
          'Success',
          'updated successfully',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          Get.context!,
        );
      } else {
        isRegisterLoading.value = false;
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
}
