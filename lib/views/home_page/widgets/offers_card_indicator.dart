import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/home_page_controller.dart';
import 'package:shop_app/controllers/shop_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OffersCardIndicator extends StatelessWidget {
  OffersCardIndicator({
    super.key,
    required this.dotPageController,
    required this.adsList,
  });
  final dynamic adsList;
  final PageController dotPageController;
  final ShopController controller = Get.put(ShopController());
  final homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 10,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 8),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      // margin: EdgeInsets.symmetric(horizontal: 12),
      child: homePageController.adsList.isEmpty
          ? SizedBox()
          : SmoothPageIndicator(
              controller: dotPageController,
              count: homePageController.adsList.isEmpty
                  ? 0
                  : homePageController.adsList.length,
              effect: CustomizableEffect(
                spacing: 8,
                dotDecoration: DotDecoration(
                    width: 10,
                    height: 10,
                    dotBorder: DotBorder(width: .5),
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999)),
                activeDotDecoration: DotDecoration(
                    width: 30,
                    height: 8,
                    color: Constans.kMainColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
    );
  }
}
