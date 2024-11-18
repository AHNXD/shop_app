import 'package:shop_app/models/product_model.dart';

class OrderDetailsModel {
  final num? id;
  final num? orderNumber;
  final String? status;
  // final num? customerId;
  // final String? customerName;
  // final String? customerContact;
  // final String? customerLocatio;
  final List<ProductModel>? products;

  OrderDetailsModel(
      {required this.id,
      required this.orderNumber,
      required this.status,
      required this.products});
  factory OrderDetailsModel.fromJson(json) {
    List<ProductModel> tempProducts = [];
    if (json['products'] != null) {
      for (var i = 0; i < json['products'].length; i++) {
        tempProducts.add(ProductModel.fromJson(json['products'][i]));
      }
    }
    return OrderDetailsModel(
        id: json['id'],
        orderNumber: json['number'],
        status: json['status'],
        products: tempProducts);
  }
}
