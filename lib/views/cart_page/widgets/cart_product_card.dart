import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/bill_controller.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/models/cart_product_model.dart';
import 'package:shop_app/views/cart_page/widgets/product_info.dart';

class CartProductCard extends StatelessWidget {
  CartProductCard({
    super.key,
    required this.model,
    required this.index,
  });
  final CartProductModel model;
  final controller = Get.put(CartController(), permanent: true);
  final billController = Get.put(BillController(), permanent: true);
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillController>(builder: (billController) {
      return Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(.1))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  constraints: const BoxConstraints(maxHeight: 130),
                  child: CachedNetworkImage(
                    color: Colors.red,
                    height: 130,
                    imageUrl: "${Constans.kImageBaseUrl}${model.image}",
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.wifi_tethering_error_rounded_sharp),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductInfo(model: model),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "الكمية : ",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontFamily: Constans.kFontFamily,
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              billController.editCart
                                  ? GetBuilder<CartController>(
                                      builder: (controller) {
                                      return Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              num currentQuantity =
                                                  model.quantity;
                                              if (currentQuantity > 1) {
                                                controller.cartOrderProducts[
                                                        index]['quantity'] =
                                                    (currentQuantity - 1)
                                                        .toString();
                                                model.quantity--;
                                                billController.getSubTotal();
                                                controller.update();
                                              }
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Constans.kMainColor),
                                          ),
                                          Text(
                                            model.quantity.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              num currentQuantity =
                                                  model.quantity;
                                              controller.cartOrderProducts[
                                                      index]['quantity'] =
                                                  (currentQuantity + 1)
                                                      .toString();
                                              model.quantity++;
                                              billController.getSubTotal();
                                              controller.update();
                                            },
                                            icon: const Icon(Icons.add,
                                                color: Constans.kMainColor),
                                          ),
                                        ],
                                      );
                                      // return Container(
                                      //   height: 40,
                                      //   decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(16)),
                                      //   clipBehavior: Clip.hardEdge,
                                      //   width: 80,
                                      //   child: TextFormField(
                                      //     onChanged: (value) {
                                      //       if (value.isNum) {
                                      //         controller.cartOrderProducts[
                                      //                 index]['quantity'] =
                                      //             value.toString();
                                      //         billController.getSubTotal();
                                      //       } else {
                                      //         controller
                                      //                 .cartOrderProducts[index]
                                      //             ['quantity'] = "1";
                                      //       }
                                      //     },
                                      //     onEditingComplete: () {
                                      //       debugPrint('Ammis');
                                      //     },
                                      //     textAlign: TextAlign.center,
                                      //     textAlignVertical:
                                      //         TextAlignVertical.center,
                                      //     initialValue:
                                      //         model.quantity.toString(),
                                      //     keyboardType:
                                      //         const TextInputType.numberWithOptions(
                                      //             signed: false),
                                      //     cursorColor: Constans.kMainColor,
                                      //     decoration: const InputDecoration(
                                      //         contentPadding:
                                      //             EdgeInsets.only(bottom: 10),
                                      //         fillColor: Color(0xFFF1F7F4),
                                      //         filled: true,
                                      //         border: InputBorder.none),
                                      //   ),
                                      // );
                                    })
                                  : Text(model.quantity.toString()),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          billController.editCart
              ? Positioned.fill(
                  child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      controller.cartProducts.removeAt(index);
                      controller.cartOrderProducts.removeAt(index);
                      debugPrint(
                          'controller.cartProducts: ${controller.cartProducts}');
                      debugPrint(
                          'controller.cartOrderProducts: ${controller.cartOrderProducts}');
                      controller.update();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            // color: const Color.fromARGB(255, 224, 85, 75),
                            color: Constans.kMainColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16))),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                  ),
                ))
              : Container()
        ],
      );
    });
  }
}
