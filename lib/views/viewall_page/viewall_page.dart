import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/products_controller.dart';
import 'package:shop_app/views/viewall_page/widgets/custom_search_bar.dart';
import 'package:shop_app/views/viewall_page/widgets/products_gridview.dart';

class ViewAllPage extends StatelessWidget {
  ViewAllPage({
    super.key,
    required this.title,
  });
  final controller = Get.put(ProductsController());
  final String title;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF3F4F6),
            scrolledUnderElevation: 0,
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily),
            ),
            centerTitle: true,
          ),
          body: GetBuilder<ProductsController>(builder: (controller) {
            return controller.productsError
                ? Center(
                    child: Text(
                      "حدث خطأ اعد المحاولة لاحقا",
                      style: TextStyle(fontFamily: Constans.kFontFamily),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomSearchBar(),
                      controller.productsLoading
                          ? Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Constans.kMainColor,
                              )),
                            )
                          : Expanded(
                              child: ProductGridView(),
                            ),
                      controller.hasMoreData || controller.productsLoading
                          ? Container()
                          : controller.productsList.isEmpty
                              ? Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                  child: const Center(
                                    child: Text(
                                      "لا يوجد منتجات لعرضها ",
                                      style: TextStyle(
                                          fontFamily: Constans.kFontFamily),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                  child: const Center(
                                    child: Text(
                                      'لقد تصفحت جميع المنتجات ولا يوجد منتجات اضافية لعرضها',
                                      style: TextStyle(
                                          fontFamily: Constans.kFontFamily),
                                    ),
                                  ),
                                )
                    ],
                  );
          }),
        ),
      );
    });
  }
}