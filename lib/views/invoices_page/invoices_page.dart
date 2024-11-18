import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/invoices_controller.dart';
import 'package:shop_app/views/invoices_page/widgets/invoices_appbar.dart';
import 'package:shop_app/views/invoices_page/widgets/invoices_list.dart';

class InvoicesPage extends StatelessWidget {
  InvoicesPage({super.key});

  final controller = Get.put(InvoicesController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.invoices(context),
        builder: (context, snapshot) {
          return GetBuilder<InvoicesController>(builder: (controller) {
            return Scaffold(
              backgroundColor: const Color(0xFFF3F4F6),
              appBar: InvoicesAppbar(),
              body: InvoicesList(),
            );
          });
        });
  }
}

