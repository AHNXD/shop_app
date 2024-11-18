import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/products_controller.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';
import 'package:shop_app/views/viewall_page/viewall_page.dart';
import '../../../../controllers/home_page_controller.dart';
import 'home_card.dart';

class HomeProductsList extends StatelessWidget {
  HomeProductsList({
    super.key,
  });
  final productsController = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return controller.categoryLoadingError
              ? Center(
                  child: Text(
                    'حدث خطأ اثناء تحميل التصنيفات',
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.homePageLoading
                          ? 4
                          : controller.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return controller.homePageLoading
                            ? const ShimmerContainer(
                                width: 200, height: 200, circularRadius: 16)
                            : GestureDetector(
                                onTap: () async {
                                  controller.selectedCategoryId =
                                      controller.categoryList[index].id.toInt();
                                  controller.update();
                                  log(controller.categoryList[index].id
                                      .toInt()
                                      .toString());
                                  productsController.selectedCategory =
                                      controller.categoryList[index].id.toInt();
                                  productsController.productsList.clear();
                                  productsController.pageNumberr = 1;
                                  productsController.searchText = '';
                                  log('selected category ${controller.categoryList[index].name.toString()}');

                                  Get.to(() => ViewAllPage(
                                      title:
                                          controller.categoryList[index].name));
                                  await productsController.getAllProducts();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Constans.kMainColor,
                                      // color: Color(0xFF679267),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: HomeCard(
                                    model: controller.categoryList[index],
                                  ),
                                ),
                              );
                      }),
                );
        });
  }
}
