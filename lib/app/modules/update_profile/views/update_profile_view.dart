import 'package:charge_mod/app/modules/update_profile/refactors/text_field.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key, required this.mobileNumber}) : super(key: key);
  final String mobileNumber;
  final UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' First Name',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  textFields(
                    hintText: "First Name",
                    keyBoardType: TextInputType.name,
                    textEditingController:
                        updateProfileController.firstNameEditingController,
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)) {
                        return 'please enter valid name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  Text(
                    ' Last Name',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  textFields(
                    hintText: "Last Name",
                    keyBoardType: TextInputType.name,
                    textEditingController:
                        updateProfileController.lastNameEditingController,
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)) {
                        return 'please enter valid name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  Text(
                    ' E-mail',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  textFields(
                    hintText: "email",
                    keyBoardType: TextInputType.emailAddress,
                    textEditingController:
                        updateProfileController.emailEditingController,
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Phone Number',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(mobileNumber,
                      style: GoogleFonts.poppins(
                          color: secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            children: [
              const Text("Completing Your Profile"),
              const SizedBox(
                height: 5,
              ),
              Text(
                  "This action will reflect in your activities and payments after saving. we ask for email details for recieving monthly activity and notifications.",
                  style: GoogleFonts.poppins(
                      color: secondaryTextColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 13,
              ),
              Obx(() {
                return ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(100.w, 43)),
                        backgroundColor:
                            const MaterialStatePropertyAll(primaryColor),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))))),
                    onPressed: updateProfileController.isRegisterLoading.value
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              updateProfileController
                                  .registerUserDetails(mobileNumber);
                            }
                          },
                    child: updateProfileController.isRegisterLoading.value
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
                            "Save Changes",
                            style: GoogleFonts.poppins(
                                color: whiteColor, fontSize: 16),
                          ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
