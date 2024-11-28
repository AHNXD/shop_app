import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constans.dart';
import '../../../controllers/categories_compnies_controller.dart';
import '../../../controllers/products_controller.dart';
import '../../home_page/widgets/home_card.dart';
import '../../shimmer/shimmer_container.dart';
import '../../viewall_page/viewall_page.dart';

class CategoirsCompaniesGridView extends StatelessWidget {
  CategoirsCompaniesGridView({super.key, this.companyId});

  final productsController = Get.put(ProductsController());
  final int? companyId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesCompniesController>(
        init: CategoriesCompniesController(),
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
                      itemCount: controller.categoryLoading
                          ? 4
                          : controller.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return controller.categoryLoading
                            ? const ShimmerContainer(
                                width: 200, height: 200, circularRadius: 16)
                            : GestureDetector(
                                onTap: () async {
                                  controller.update();
                                  log(controller.categoryList[index].id
                                      .toInt()
                                      .toString());
                                  productsController.selectedCategory =
                                      controller.categoryList[index].id.toInt();
                                  productsController.companyId = companyId;
                                  productsController.productsList.clear();
                                  productsController.pageNumberr = 1;
                                  productsController.searchText = '';
                                  log('selected category ${controller.categoryList[index].name.toString()}');
                                  log('selected company $companyId');
                                  Get.to(() => ViewAllPage(
                                      categoryId: controller
                                          .categoryList[index].id
                                          .toInt(),
                                      companyId: companyId,
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
