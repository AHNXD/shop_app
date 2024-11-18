import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.model,
    required this.isOrderCard,
    this.orderCompanyName,
  });
  final ProductModel model;
  final pageController = PageController();
  final controller = Get.put(CartController(), permanent: true);
  final bool isOrderCard;
  final String? orderCompanyName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) => CachedNetworkImage(
                            color: Colors.white,
                            width: 64,
                            height: 64,
                            imageUrl:
                                "${Constans.kImageBaseUrl}${model.images![index]}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.wifi_tethering_error_rounded_sharp),
                          ),
                          itemCount: model.images!.length,
                        ),
                        Positioned.fill(
                          top: 4,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SmoothPageIndicator(
                                effect: CustomizableEffect(
                                    dotDecoration: DotDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        width: 12,
                                        height: 12,
                                        borderRadius:
                                            BorderRadius.circular(999)),
                                    activeDotDecoration: DotDecoration(
                                        color: Constans.kMainColor,
                                        width: 12,
                                        height: 12,
                                        borderRadius:
                                            BorderRadius.circular(999))),
                                controller: pageController,
                                count: model.images!.length),
                          ),
                        )
                      ],
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        model.name ?? '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constans.kFontFamily),
                      ),
                      Text(
                        isOrderCard
                            ? orderCompanyName!
                            : model.company.toString(),
                        style: const TextStyle(
                            color: Colors.black26,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constans.kFontFamily),
                      ),
                      Text(
                        '${model.price} ل.س ',
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constans.kFontFamily),
                      ),
                      isOrderCard
                          ? Text(
                              'الكمية ${model.quantity}',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constans.kFontFamily),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isOrderCard
              ? Container()
              : Positioned.fill(
                  child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () async {
                      var status = await controller.addToCart(
                          model.id.toString(), context);
                      if (status) {
                        controller.cartOrderProducts
                            .add({'id': model.id.toString(), 'quantity': "1"});
                        controller.update();
                        debugPrint(
                            'controller.cartOrderProducts: ${controller.cartOrderProducts}');
                      }
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Constans.kMainColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16))),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ))
        ],
      ),
    );
  }
}
