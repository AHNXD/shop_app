import 'package:shop_app/models/archive_product_model.dart';

class ArchiveOrderModel {
  final num id;
  final num orderNumber;
  final String? companyName;
  final String? companyImage;
  final num? productsNumber;
  final String? date;
  final List<ArchiveProductModel>? products;

  ArchiveOrderModel(
      {required this.id,
      required this.orderNumber,
      required this.companyName,
      required this.companyImage,
      required this.productsNumber,
      required this.date,
      required this.products});
  factory ArchiveOrderModel.fromJson(json) {
    List<ArchiveProductModel> tempProducts = [];
    if (json['products'] != null) {
      for (var i = 0; i < json['products'].length; i++) {
        tempProducts.add(ArchiveProductModel.fromJson(json['products'][i]));
      }
    }
    return ArchiveOrderModel(
        id: json['id'],
        orderNumber: json['number'],
        companyName: json['company']??'',
        companyImage: json['company_image']??'',
        productsNumber: json['products'].length,
        date: json['date'],
        products: tempProducts);
  }
}
