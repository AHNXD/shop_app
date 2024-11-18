class ArchiveProductModel {
  final String name;
  final num price;
  final num quantity;

  ArchiveProductModel(
      {required this.name, required this.price, required this.quantity});
  factory ArchiveProductModel.fromJson(json) {
    return ArchiveProductModel(
        name: json['name'], price: json['price'], quantity: json['quantity']);
  }
}
