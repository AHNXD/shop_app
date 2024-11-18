import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/navigation_controller.dart';

class NavBarItem extends StatelessWidget {
  NavBarItem({
    super.key,
    required this.index,
    required this.image,
  });
  final controller = Get.put(NavigationController());
  final int index;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.selectedIndex = index;
          controller.update();
        },
        child: CircleAvatar(
          radius: 28,
          backgroundColor: controller.selectedIndex == index
              ? Constans.kMainColor
              : Colors.transparent,
          child: Image.asset(
            width: 28,
            image,
            color:
                controller.selectedIndex == index ? Colors.white : Colors.black,
          ),
          // child: Icon(
          //   icon,
          //   color:
          //       controller.selectedIndex == index ? Colors.white : Colors.black,
          // ),
        ),
      );
    });
  }
}
