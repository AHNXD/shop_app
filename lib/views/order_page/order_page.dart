import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/order_page_controller.dart';
import 'package:shop_app/views/order_page/archives_order/archives_order_page.dart';
import 'package:shop_app/views/order_page/widgets/tabbar_taps.dart';
import 'package:shop_app/views/order_page/widgets/tapbar_body.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});
  final controller = Get.put(OrderPageController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF3F4F6),
          title: const Text(
            "الطلبات",
            style: TextStyle(
                color: Colors.black,
                fontFamily: Constans.kFontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 24),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const ArchivesOrderPage());
                },
                icon: const Icon(Icons.archive_sharp))
          ],
        ),
        backgroundColor: const Color(0xFFF3F4F6),
        body: FutureBuilder(
            future: controller.getAllOrder(context),
            builder: (context, snapshot) {
              debugPrint('snapshot: ${snapshot.data}');
              return const Column(
                children: [
                  TabBarTaps(),
                  Expanded(
                    child: TabBarView(children: [
                      TabBarBody(
                        id: 1,
                      ),
                      TabBarBody(
                        id: 2,
                      ),
                      TabBarBody(
                        id: 3,
                      ),
                      TabBarBody(
                        id: 4,
                      ),
                    ]),
                  )
                ],
              );
            }),
      ),
    );
  }
}
