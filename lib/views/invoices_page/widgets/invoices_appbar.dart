import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/invoices_controller.dart';

class InvoicesAppbar extends StatelessWidget implements PreferredSizeWidget {
  InvoicesAppbar({
    super.key,
  });
  final controller = Get.put(InvoicesController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF3F4F6),
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: const Text(
        "الفواتير",
        style: TextStyle(fontFamily: Constans.kFontFamily, fontSize: 22),
      ),
      actions: [
        IconButton(
            onPressed: () {
              controller.showFilter = !controller.showFilter;
              controller.update();
            },
            icon: const Icon(Icons.filter_list_rounded))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 58);
}
