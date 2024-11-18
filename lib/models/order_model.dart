import 'package:shop_app/models/product_model.dart';

class OrderModel {
  final num id;
  final num orderNumber;
  final num? companyId;
  final String? companyName;
  final String? archiveCompanyName;
  final String? companyImage;
  final num? totalPrice;
  final num? productsNumber;
  final String? orderDate;
  final String? orderStatus;
  final String? date;
  final String? explaination;
  final bool? canCancel;
  final List<ProductModel>? products;

  OrderModel(
      {required this.id,
      required this.orderNumber,
      required this.companyId,
      required this.companyName,
      required this.archiveCompanyName,
      required this.companyImage,
      required this.totalPrice,
      required this.productsNumber,
      required this.orderDate,
      required this.orderStatus,
      required this.date,
      required this.explaination,
      required this.canCancel,
      required this.products});
  factory OrderModel.fromJson(json) {
    List<ProductModel> tempProducts = [];
    if (json['products'] != null) {
      for (var i = 0; i < json['products'].length; i++) {
        tempProducts.add(ProductModel.fromJson(json['products'][i]));
      }
    }
    return OrderModel(
        id: json['id'],
        orderNumber: json['number'],
        companyId: json['company']['id'],
        companyName: json['company']['name'].toString(),
        archiveCompanyName: json['company'].toString(),
        companyImage: json['company']['image'],
        totalPrice: json['total_price'],
        productsNumber: json['products_number'],
        orderDate: json['order_date'],
        orderStatus: json['status'],
        date: json['date'],
        explaination: json['explanation'],
        canCancel: json['can_cancel'],
        products: tempProducts);
  }
}

// class AcceptedOrderModel {
//   final num id;
//   final num orderNumber;
//   final num companyId;
//   final String companyName;
//   final String companyImage;
//   final num totalPrice;
//   final String date;

//   AcceptedOrderModel(
//       {required this.id,
//       required this.orderNumber,
//       required this.companyId,
//       required this.companyName,
//       required this.companyImage,
//       required this.totalPrice,
//       required this.date});
//   // final String? explanation;
//   // final String? successDate;
//   factory AcceptedOrderModel.fromJson(json) {
//     return AcceptedOrderModel(
//         id: json['id'],
//         orderNumber: json['number'],
//         companyId: json['company']['id'],
//         companyName: json['company']['name'],
//         companyImage: json['company']['image'],
//         totalPrice: json['total_price'],
//         date: json['date']);
//   }
// }

// class CancelledOrderModel {
//   final num id;
//   final num orderNumber;
//   final num companyId;
//   final String companyName;
//   final String companyImage;
//   final String explaination;

//   CancelledOrderModel(
//       {required this.id,
//       required this.orderNumber,
//       required this.companyId,
//       required this.companyName,
//       required this.companyImage,
//       required this.explaination});
//   // final String? explanation;
//   // final String? successDate;
//   factory CancelledOrderModel.fromJson(json) {
//     return CancelledOrderModel(
//       id: json['id'],
//       orderNumber: json['number'],
//       companyId: json['company']['id'],
//       companyName: json['company']['name'],
//       companyImage: json['company']['image'],
//       explaination: json['explanation'],
//     );
//   }
// }
