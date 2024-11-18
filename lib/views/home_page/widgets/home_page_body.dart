import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_page_controller.dart';
import 'package:shop_app/controllers/shop_controller.dart';
import 'package:shop_app/views/home_page/widgets/home_product_list.dart';
import 'package:shop_app/views/home_page/widgets/offers_card_indicator.dart';
import 'package:shop_app/views/home_page/widgets/offers_page_view.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody({
    super.key,
  });

  final ShopController shopPageController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: GetBuilder<HomePageController>(
              init: HomePageController(),
              builder: (controller) {
                controller.update();
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    controller.homePageLoading
                        ? ShimmerContainer(
                            width: MediaQuery.sizeOf(context).width,
                            height: 230,
                            circularRadius: 16,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          )
                        : Container(
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(0),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: OffersPageView(
                                    dotPageController:
                                        shopPageController.pageController,
                                    adsList: controller.adsList,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: OffersCardIndicator(
                                    dotPageController:
                                        shopPageController.pageController,
                                    adsList: controller.adsList,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("التصنيفات",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Cairo',
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        HomeProductsList(),
                      ],
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
