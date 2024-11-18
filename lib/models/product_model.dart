
class ProductModel {
  final num? id;
  final String? name;
  final num? price;
  final num? quantity;
  final String? unitType;
  final String? company;
  final List<String>? images;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.unitType,
      required this.company,
      required this.images});

  factory ProductModel.fromJson(json) {
    List<String>? tempImages = [];
    if (json['images'] != null) {
      json['images'].forEach((val) {
        tempImages.add(val['image']);
      });
    }
    return ProductModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        unitType: json['unit_type'],
        company: json['company']??'test',
        images: tempImages,
        quantity: json['quantity']);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
