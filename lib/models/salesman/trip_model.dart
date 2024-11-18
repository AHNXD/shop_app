class TripModel {
  final num id;
  final num addressId;
  final String addressName;
  final num? ordersNumber;
  final String? date;

  TripModel(
      {required this.id,
      required this.addressId,
      required this.addressName,
      required this.ordersNumber,
      required this.date});
  factory TripModel.fromJson(json) {
    return TripModel(
        id: json['id'],
        addressId: json['address']['id'],
        addressName: json['address']['name'],
        ordersNumber: json['orders_number'],
        date: json['date']);
  }
}
