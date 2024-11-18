
import 'package:flutter/material.dart';
import 'package:shop_app/models/salesman/order_details_model.dart';
import 'package:shop_app/views/salesman_app/order_details.dart/salesman_archive_card.dart';
import 'package:shop_app/views/viewall_page/widgets/product_card.dart';

class DetailsOrderProductsList extends StatelessWidget {
  const DetailsOrderProductsList({
    super.key,
    required this.isArchive,
    required this.orderModel,
  });

  final bool isArchive;
  final OrderDetailsModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: isArchive
          ? GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.8,
              ),
              itemCount: orderModel.products!.length,
              itemBuilder: (context, index) {
                return IntrinsicHeight(
                  child: SalesmanArchiveCard(
                    model: orderModel.products![index],
                  ),
                );
              })
          : GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7),
              itemCount: orderModel.products!.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  model: orderModel.products![index],
                  isOrderCard: true,
                  orderCompanyName: '',
                );
              }),
    );
  }
}
