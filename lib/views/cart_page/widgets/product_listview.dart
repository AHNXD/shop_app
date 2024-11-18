import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/views/cart_page/widgets/cart_product_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({
    super.key,
  });

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final controller = Get.put(CartController(), permanent: true);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getCartProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return controller.cartLoadingError && !controller.cartLoading
          ? Center(
              child: Center(
                child: Text(
                  'حدث خطأ اثناء تحميل منتجات السلة',
                  style: TextStyle(fontFamily: Constans.kFontFamily),
                ),
              ),
            )
          : controller.cartProducts.isEmpty && !controller.cartLoading
              ? Center(
                  child: Text(
                    'لا يوجد اي منتجات ضمن السلة ',
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.cartLoading
                      ? 4
                      : controller.cartProducts.length,
                  itemBuilder: (context, index) {
                    return controller.cartLoading
                        ? ShimmerContainer(
                            width: MediaQuery.sizeOf(context).height,
                            height: 130,
                            circularRadius: 16,
                            margin: const EdgeInsets.all(8),
                          )
                        : CartProductCard(
                            model: controller.cartProducts[index],
                            index: index,
                          );
                  });
    });
  }
}
