// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/invoices_controller.dart';
import 'package:shop_app/models/invoices_model.dart';
import 'package:shop_app/views/invoices_page/widgets/invoice_info.dart';

class InvoiceCard extends StatelessWidget {
  InvoiceCard({
    super.key,
    required this.model,
  });
  final InvoicesModel model;
  final controller = Get.put(InvoicesController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(.1))
            ],
            color: Colors.white.withOpacity(.7),
            borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceInfo(
                  icon: Icons.numbers,
                  title: 'رقم الفاتورة',
                  subTitle: "${model.id}",
                  color: const Color.fromARGB(255, 203, 209, 146),
                ),
                const SizedBox(
                  height: 20,
                ),
                InvoiceInfo(
                  icon: FontAwesomeIcons.dollarSign,
                  title: 'قيمة الفاتورة',
                  subTitle: "${model.amount} ل.س",
                  color: Constans.kMainColor,
                ),
              ],
            ),
            const Spacer(
              flex: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceInfo(
                  icon: Icons.numbers,
                  title: "تاريخ الدفع",
                  subTitle: model.date,
                  color: Constans.kMainColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                InvoiceInfo(
                  icon: FontAwesomeIcons.buildingColumns,
                  title: 'الشركة',
                  subTitle: model.companyName,
                  color: const Color.fromARGB(255, 203, 209, 146),
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
