class UserInvoiceInfo {
  final num id;
  final String? name;
  final String? contact;
  final num? totalPurchases;
  final num? totalPayments;
  final num? remaining;
  UserInvoiceInfo(
      {required this.id,
      required this.name,
      required this.contact,
      required this.totalPurchases,
      required this.totalPayments,
      required this.remaining});
  factory UserInvoiceInfo.fromJson(json) {
    return UserInvoiceInfo(
        id: json['id'],
        name: json['name'],
        contact: json['contact'],
        totalPurchases: json['total_purchases'],
        totalPayments: json['total_payments'],
        remaining: json['remaining']);
  }
}
