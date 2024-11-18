import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/navigation_controller.dart';
import 'package:shop_app/views/home_page/widgets/custom_navigationbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(),
        body: GetBuilder<NavigationController>(
            init: NavigationController(),
            builder: (controller) {
              return controller.screens[controller.selectedIndex];
            }),
      ),
    );
  }
}
