import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/navigation_controller.dart';
import 'package:shop_app/utils/app_images.dart';
import 'package:shop_app/views/home_page/widgets/nav_bar_item.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    super.key,
  });
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        height: 116,
        elevation: 0,
        selectedIndex: controller.selectedIndex,
        destinations: [
          NavBarItem(
            index: 0,
            image: Assets.assetsImagesHomeIcon,
          ),
          NavBarItem(
            index: 1,
            image: Assets.assetsImagesOrder2,
          ),
          NavBarItem(index: 2, image: Assets.assetsImagesInvoicesIcon),
          NavBarItem(index: 3, image: Assets.assetsImagesCartIcon),
        ],
      ),
    );
  }
}
