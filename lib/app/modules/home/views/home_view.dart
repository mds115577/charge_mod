import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/home/home_bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    child: FutureBuilder(
                        future: homeController.getLocationDatas(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ],
                            );
                          }
                          return Obx(() {
                            return ListView.separated(
                                controller: homeController.scrollScontroller,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 9,
                                  );
                                },
                                itemCount: homeController.locationLists.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      homeController.locationLists[index];
                                  return SizedBox(
                                    height: 60,
                                    width: 80.w,
                                    child: ListTile(
                                      tileColor: whiteColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(9))),
                                      title: Text(
                                        data.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: primaryTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text(
                                          data.geoLocation.coordinates
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            color: secondaryTextColor,
                                          )),
                                    ),
                                  );
                                });
                          });
                        }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
