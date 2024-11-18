
import 'package:flutter/material.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/views/viewall_page/widgets/product_card.dart';

class OrderDetailsProducts extends StatelessWidget {
  const OrderDetailsProducts({
    super.key,
    required this.model,
  });

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7),
          itemCount: model.products != null
              ? model.products!.length
              : 0,
          itemBuilder: (context, index) {
            return ProductCard(
              model: model.products![index],
              isOrderCard: true,
              orderCompanyName: model.companyName ??
                  model.archiveCompanyName ??
                  '',
            );
          }),
    );
  }
}
