import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/products_controller.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/views/viewall_page/widgets/product_card.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({
    super.key,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  final controller = Get.put(ProductsController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.custom(
          controller: controller.scrollController,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 12,
            pattern: [
              WovenGridTile(0.6),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 1,
                alignment: AlignmentDirectional.center,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => index < controller.productsList.length
                ? ProductCard(
                    model:
                        ProductModel.fromJson(controller.productsList[index]),
                    isOrderCard: false,
                  )
                : Center(
                    child:
                        CircularProgressIndicator(color: Constans.kMainColor),
                  ),
            childCount: controller.isLoadingMoreData
                ? controller.productsList.length + 1
                : controller.productsList.length,
          ),
        ),
      );
    });
  }
}
