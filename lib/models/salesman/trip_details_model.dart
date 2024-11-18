import 'package:shop_app/models/salesman/trip_order_model.dart';

class TripDetailsModel {
  final num id;
  final num addressId;
  final String addressName;
  final num? customersCount;
  final num? ordersNumbers;
  final String? date;
  final List<TripOrderModel> pendingOrders;
  final List<TripOrderModel> archivesOrders;

  TripDetailsModel(
      {required this.id,
      required this.addressId,
      required this.addressName,
      required this.customersCount,
      required this.ordersNumbers,
      required this.date,
      required this.pendingOrders,
      required this.archivesOrders
      });

  factory TripDetailsModel.fromJson(json) {
    List<TripOrderModel> tempPendingOrders = [];
    List<TripOrderModel> tempArchivesOrders = [];
    if (json['pending_orders'] != null) {
      for (var i = 0; i < json['pending_orders'].length; i++) {
        tempPendingOrders.add(TripOrderModel.fromJson(json['pending_orders'][i]));
      }
    }
    if (json['archive_orders'] != null) {
      for (var i = 0; i < json['archive_orders'].length; i++) {
        tempArchivesOrders.add(TripOrderModel
        .fromJson(json['archive_orders'][i]));
      }
    }
    return TripDetailsModel(
        id: json['trip']['id'],
        addressId: json['trip']['address']['id'],
        addressName: json['trip']['address']['name'],
        customersCount: json['trip']['address']['customers_count'],
        ordersNumbers: json['trip']['orders_number'],
        date: json['trip']['date'],
        pendingOrders: tempPendingOrders,
        archivesOrders: tempArchivesOrders
    );
  }

  @override
  String toString() {
    return 'TripDetailsModel(id: $id, addressId: $addressId, addressName: $addressName, '
           'customersCount: $customersCount, ordersNumbers: $ordersNumbers, date: $date, '
           'pendingOrders: $pendingOrders)';
  }
}
