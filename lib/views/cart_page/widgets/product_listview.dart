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
  final cartcontroller = Get.put(CartController(), permanent: true);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cartcontroller.getCartProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return cartController.cartLoadingError && !cartController.cartLoading
          ? Center(
              child: Center(
                child: Text(
                  'حدث خطأ اثناء تحميل منتجات السلة',
                  style: TextStyle(fontFamily: Constans.kFontFamily),
                ),
              ),
            )
          : cartController.cartProducts.isEmpty && !cartController.cartLoading
              ? Center(
                  child: Text(
                    'لا يوجد اي منتجات ضمن السلة ',
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                )
              : ListView.builder(
                  itemCount: cartController.cartLoading
                      ? 4
                      : cartController.cartProducts.length,
                  itemBuilder: (context, index) {
                    return cartController.cartLoading
                        ? ShimmerContainer(
                            width: MediaQuery.sizeOf(context).height,
                            height: 130,
                            circularRadius: 16,
                            margin: const EdgeInsets.all(8),
                          )
                        : CartProductCard(
                            model: cartController.cartProducts[index],
                            index: index,
                          );
                  });
    });
  }
}
