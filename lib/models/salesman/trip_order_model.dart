class TripOrderModel {
  final num id;
  final num number;
  final num? totalPrice;
  final String? status;
  final num? customerId;
  final String? customerName;
  final String? customerContact;
  final String? customerLocation;
  final String? date;
  final num? productsNumber;

  TripOrderModel(
      {required this.id,
      required this.number,
      required this.totalPrice,
      required this.status,
      required this.customerId,
      required this.customerName,
      required this.customerContact,
      required this.customerLocation,
      required this.date,
      required this.productsNumber});
  factory TripOrderModel.fromJson(json) {
    return TripOrderModel(
        id: json['id'],
        number: json['number'],
        totalPrice: json['total_price'],
        status: json['status'],
        customerId: json['customer']['id'],
        customerName: json['customer']['name'],
        customerContact: json['customer']['contact'],
        customerLocation: json['customer']['location'],
        date: json['date'] ?? '',
        productsNumber: json['products_number']);
  }
}
