import 'package:charge_mod/app/modules/activity/views/activity_view.dart';
import 'package:charge_mod/app/modules/community/views/community_view.dart';
import 'package:charge_mod/app/modules/home/views/home_view.dart';
import 'package:charge_mod/app/modules/profile/views/profile_view.dart';
import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);

  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(),
      const ActivityView(),
      const CommunityView(),
      ProfileView(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: BottomBarView.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: BottomNavigationBar(
                selectedItemColor: primaryColor,
                backgroundColor: const Color(0xfff2f2f2),
                currentIndex: updatedIndex,
                unselectedItemColor: primaryTextColor,
                onTap: ((newIndex) {
                  BottomBarView.selectedPageIndex.value = newIndex;
                }),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: CustomSvgIcon(
                        assetPath: selectedPageIndex.value != 0
                            ? 'assets/bottom_bar/home.svg'
                            : 'assets/bottom_bar/home_selected.svg',
                        size: 24,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: CustomSvgIcon(
                        assetPath: selectedPageIndex.value != 1
                            ? 'assets/bottom_bar/activity.svg'
                            : 'assets/bottom_bar/activity_selected.svg',
                        size: 24,
                      ),
                      label: 'Activity'),
                  BottomNavigationBarItem(
                      icon: CustomSvgIcon(
                        assetPath: selectedPageIndex.value != 2
                            ? 'assets/bottom_bar/community.svg'
                            : 'assets/bottom_bar/community_selected.svg',
                        size: 24,
                      ),
                      label: 'Community'),
                  BottomNavigationBarItem(
                      icon: CustomSvgIcon(
                        assetPath: selectedPageIndex.value != 3
                            ? 'assets/bottom_bar/profile.svg'
                            : 'assets/bottom_bar/profile_selected.svg',
                        size: 24,
                      ),
                      label: 'Profile')
                ]),
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return pages[updatedIndex];
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;

  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,

        // color: color,
      ),
    );
  }
}
