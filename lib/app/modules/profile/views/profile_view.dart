import 'package:charge_mod/app/modules/profile/refactors/info_widget.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
              future: profileController.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: primaryColor,
                  );
                }
                final firstName = profileController
                    .capitalize(profileController.firstName.value);
                final lastName = profileController
                    .capitalize(profileController.lastName.value);

                return Column(
                  children: [
                    Text(
                      "Hello",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "$firstName $lastName",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              }),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                children: [
                  const InfoWidget(),
                  Card(
                    elevation: 3,
                    surfaceTintColor: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 0, bottom: 19, right: 0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/payments.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("My Payments"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/my_electric.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("My Electric Vehicles"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/favorite.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("My Favourite Stations"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/alpha.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("Alpha Membership"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStatePropertyAll(Size(100.w, 45)),
                            backgroundColor:
                                const MaterialStatePropertyAll(primaryColor),
                            shape: const MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))))),
                        onPressed: () {},
                        child: Text(
                          "Buy Machines From chargeMOD",
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 3,
                    surfaceTintColor: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 0, bottom: 19, right: 0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/mydevice.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("My Devices"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/my_orders.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("My Orders"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 3,
                    surfaceTintColor: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 0, bottom: 19, right: 0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/help.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("Help"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/raise_complaint.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("Raise Complaint"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/about_us.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("About Us"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 19.0, right: 19, bottom: 10),
                            child: Divider(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/profile/privacy_policy.svg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text("Privacy Policy"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStatePropertyAll(Size(100.w, 45)),
                            backgroundColor:
                                const MaterialStatePropertyAll(primaryColor),
                            shape: const MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))))),
                        onPressed: () {
                          profileController
                              .dialogPopForAccountDeletion(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/profile/logout_icon.svg"),
                            Text(
                              "  Logout",
                              style: GoogleFonts.poppins(
                                  color: whiteColor, fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SvgPicture.asset("assets/profile/vcs.svg")],
                    ),
                  ),
                  Text(
                    "V 1.0.0 (001)",
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Copyright © 2022 BPM Power Pvt Ltd.\nAll rights reserved.",
                      style: GoogleFonts.poppins(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
