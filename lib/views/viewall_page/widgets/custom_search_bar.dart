import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/products_controller.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, this.categoryId, this.companyId});
  final int? categoryId;
  final int? companyId;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  int counter = 0;
  final controller = Get.put(ProductsController());
  bool showFilter = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    onSubmitted: (data) async {
                      controller.searchText = data;
                      controller.productsList = [];
                      controller.pageNumberr = 1;
                      controller.productsLoading = true;
                      controller.selectedCategory = widget.categoryId;
                      controller.companyId = widget.companyId;
                      controller.update();
                      await controller.getAllProducts();
                      controller.productsLoading = false;
                      controller.update();
                      debugPrint(
                          'controller.productsList: ${controller.productsList}');
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "ابحث هنا...",
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3), height: 2),
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ])
        ]);
  }
}
