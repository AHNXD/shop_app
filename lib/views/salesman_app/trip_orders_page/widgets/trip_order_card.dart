import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/order_controller.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/models/salesman/order_details_model.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/models/salesman/trip_order_model.dart';
import 'package:shop_app/views/salesman_app/order_details.dart/salesman_order_details.dart';

class TripOrderCard extends StatefulWidget {
  const TripOrderCard(
      {super.key,
      required this.model,
      required this.isArchive,
      required this.pendingOrder,
      required this.orderIndex,
      required this.tripModel});
  final TripOrderModel? model;
  final List<TripOrderModel> pendingOrder;
  final bool isArchive;
  final int orderIndex;
  final TripModel tripModel;

  @override
  State<TripOrderCard> createState() => _TripOrderCardState();
}

class _TripOrderCardState extends State<TripOrderCard> {
  final orderController = Get.put(OrderController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (tripController) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Constans.kMainColor,
                                    borderRadius: BorderRadius.circular(999)),
                                child: const Icon(
                                  FontAwesomeIcons.sackDollar,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'السعر',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: Constans.kFontFamily,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: Text(
                                    maxLines: 2,
                                    "${widget.model!.totalPrice} ل.س",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(.2),
                                        fontFamily: Constans.kFontFamily,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 203, 209, 146),
                                    borderRadius: BorderRadius.circular(999)),
                                child: const Icon(
                                  Icons.numbers_outlined,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'عدد المنتجات',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: Constans.kFontFamily,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: Text(
                                    maxLines: 2,
                                    '${widget.model!.productsNumber}',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(.2),
                                        fontFamily: Constans.kFontFamily,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          child: Text(
                            "اسم الزبون : ${widget.model!.customerName}",
                            maxLines: 2,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                color: Colors.black.withOpacity(.2),
                                fontFamily: Constans.kFontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "رقم الطلب : ${widget.model!.number}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.2),
                              fontFamily: Constans.kFontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'حالة الطلب : ${widget.model!.status == 'pending' ? 'قيد المعالجة' : widget.model!.status == 'accepted' ? "مقبولة" : (widget.model!.status == 'missing') ? "مفقودة" : (widget.model!.status == 'cancelled') ? 'مرفوضة' : "تم التسليم"}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.2),
                              fontFamily: Constans.kFontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: orderController.showOrderLoading
                                ? null
                                : widget.isArchive
                                    ? () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          OrderDetailsModel orderModel =
                                              await orderController
                                                  .showArchiveOrder(
                                                      widget.model!.id
                                                          .toString(),
                                                      context);
                                          isLoading = false;
                                          setState(() {});
                                          Get.to(() => SalesmanOrderDetails(
                                                tripModel: widget.tripModel,
                                                orderModel: orderModel,
                                                isArchive: true,
                                              ));
                                        } on Exception catch (e) {
                                          debugPrint('e: ${e}');
                                          isLoading = false;
                                          setState(() {});
                                        }
                                      }
                                    : () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          OrderDetailsModel orderModel =
                                              await orderController.showOrder(
                                                  widget.model!.id.toString(),
                                                  context);
                                          isLoading = false;
                                          setState(() {});
                                          Get.to(() => SalesmanOrderDetails(
                                              tripModel: widget.tripModel,
                                              pendingOrders:
                                                  widget.pendingOrder,
                                              orderModel: orderModel,
                                              isArchive: false,
                                              orderIndex: widget.orderIndex));
                                        } on Exception catch (e) {
                                          debugPrint('e: ${e}');
                                          isLoading = false;
                                          setState(() {});
                                        }
                                      },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Constans.kMainColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'تفاصيل',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: Constans.kFontFamily,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
