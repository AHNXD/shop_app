import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/invoices_controller.dart';
import 'package:shop_app/views/invoices_page/widgets/filter_invoices.dart';
import 'package:shop_app/views/invoices_page/widgets/invoice_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class InvoicesList extends StatelessWidget {
  InvoicesList({
    super.key,
  });
  final controller = Get.put(InvoicesController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(builder: (controller) {
      return Column(
        children: [
          controller.showFilter ? const FilterInvoices() : Container(),
          controller.invoicesError
              ? Expanded(
                  child: Center(
                    child: Text(
                      'حدث خطأ اثناء تحميل الفواتير',
                      style: TextStyle(fontFamily: Constans.kFontFamily),
                    ),
                  ),
                )
              : controller.invoicesList.isEmpty &&
                      !controller.invoicesLoading &&
                      !controller.invoicesError
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'لا يوجد فواتير لعرضها',
                          style: TextStyle(fontFamily: Constans.kFontFamily),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: controller.invoicesLoading
                              ? 4
                              : controller.invoicesList.length,
                          itemBuilder: (context, index) {
                            return controller.invoicesLoading
                                ? ShimmerContainer(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 150,
                                    circularRadius: 20,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  )
                                : InvoiceCard(
                                    model: controller.invoicesList[index],
                                  );
                          }),
                    ),
        ],
      );
    });
  }
}
