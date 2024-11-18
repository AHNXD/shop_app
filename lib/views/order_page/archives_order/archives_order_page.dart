import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/order_page_controller.dart';
import 'package:shop_app/views/order_page/widgets/order_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class ArchivesOrderPage extends StatefulWidget {
  const ArchivesOrderPage({super.key});

  @override
  State<ArchivesOrderPage> createState() => _ArchivesOrderPageState();
}

class _ArchivesOrderPageState extends State<ArchivesOrderPage> {
  final controller = Get.put(OrderPageController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getAllArchivesOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF3F4F6),
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            "الارشيف",
            style: TextStyle(fontFamily: Constans.kFontFamily, fontSize: 22),
          ),
        ),
        body: GetBuilder<OrderPageController>(
            init: OrderPageController(),
            builder: (controller) {
              return controller.archivesOrdersLoading &&
                      !controller.archivesOrdersError
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Constans.kMainColor,
                      ),
                    )
                  : controller.archivesOrdersError
                      ? Center(
                          child: Text(
                            'حدث خطأ',
                            style: TextStyle(fontFamily: Constans.kFontFamily),
                          ),
                        )
                      : controller.archivesOrders.isEmpty
                          ? Center(
                              child: Text(
                                'لا يوجد طلبات لعرضها',
                                style:
                                    TextStyle(fontFamily: Constans.kFontFamily),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.archivesOrdersLoading
                                  ? 4
                                  : controller.archivesOrders.length,
                              itemBuilder: (context, index) {
                                return controller.archivesOrdersLoading
                                    ? ShimmerContainer(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 150,
                                        circularRadius: 16,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                      )
                                    : OrderCard(
                                        model: controller.archivesOrders[index],
                                        id: 5,
                                        isArchived: true,
                                      );
                              });
            }),
      ),
    );
  }
}
