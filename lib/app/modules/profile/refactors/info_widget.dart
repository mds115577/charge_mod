import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Container(
        width: 100.w,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9)),
            image: DecorationImage(
                image: AssetImage("assets/profile/profile_info_bg.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, left: 19, bottom: 19, right: 19),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Energy Balance",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("99999 kWH",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: primaryTextColor,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "Added 100 kWH on 20/11/2022",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 54,
                          width: 61,
                          child:
                              SvgPicture.asset("assets/profile/badge_name.svg"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(144, 30)),
                          backgroundColor:
                              MaterialStatePropertyAll(greenButtonColor),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))))),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: whiteColor,
                          ),
                          Text(
                            "Add Energy",
                            style: TextStyle(color: whiteColor),
                          )
                        ],
                      )),
                  ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(144, 30)),
                          side: MaterialStatePropertyAll(
                              BorderSide(color: primaryTextColor, width: 2)),
                          backgroundColor: MaterialStatePropertyAll(whiteColor),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/profile/coins.svg",
                            height: 25,
                            width: 25,
                          ),
                          const Text(" 55 Points",
                              style: TextStyle(color: primaryTextColor))
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
