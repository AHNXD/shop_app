// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/order_page_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/archive_order_model.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/views/order_details_page.dart/widgets/archive_order_details_page.dart';
import 'package:shop_app/views/order_details_page.dart/order_details_page.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    required this.model,
    required this.id,
    required this.isArchived,
  });
  final OrderModel model;
  final int id;
  final bool isArchived;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final controller = Get.put(OrderPageController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              '${widget.model.totalPrice ?? 'طلب مرفوض'}${widget.model.totalPrice == null ? '' : 'ل.س'}',
                              style: TextStyle(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 203, 209, 146),
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
                          Text(
                            '${widget.model.productsNumber}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(.2),
                                fontFamily: Constans.kFontFamily,
                                fontWeight: FontWeight.bold),
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
                  Text(
                    "رقم الطلب : ${widget.model.orderNumber}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.2),
                        fontFamily: Constans.kFontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.model.explaination == null)
                    Text(
                      "${'التاريخ'}: ${widget.model.orderDate ?? widget.model.date ?? "لم يحدد بعد"}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.2),
                          fontSize: 14,
                          fontFamily: Constans.kFontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                  if (widget.model.explaination != null)
                    Text(
                      "${"السبب"}: ${widget.model.explaination}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.2),
                          fontSize: 14,
                          fontFamily: Constans.kFontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Text(
                      'حالة الطلب : ${widget.id == 1 ? 'قيد المعالجة' : widget.id == 2 ? "مقبولة" : (widget.id == 3) ? "مفقودة" : (widget.id == 4) ? 'مرفوضة' : "تم التسليم"}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(.2),
                          fontFamily: Constans.kFontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              var data = widget.isArchived
                                  ? await controller.showArchiveOrder(
                                      widget.model.id.toString(), context)
                                  : await controller.showOrder(
                                      widget.model.id.toString(), context);
                              setState(() {
                                isLoading = false;
                              });
                              if (data != false) {
                                widget.isArchived
                                    ? Get.to(() => ArchiveOrderDetailsPage(
                                          model:
                                              ArchiveOrderModel.fromJson(data),
                                        ))
                                    : Get.to(() => OrderDetailsPage(
                                          model: OrderModel.fromJson(data),
                                        ));
                              } else {
                                showErrorSnackBar(
                                        'حدث خطأ', "اعد المحاولة لاحقا")
                                    .show(context);
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
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'تفاصيل',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: Constans.kFontFamily,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      )),
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
  }
}
