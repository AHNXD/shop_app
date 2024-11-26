class CartProductModel {
  final num id;
  final String name;
  final num price;
  num quantity;
  final String image;
  final String category;
  final num companyId;
  final String companyName;

  CartProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.image,
      required this.category,
      required this.companyId,
      required this.companyName});

  factory CartProductModel.fromJson(json) {
    return CartProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      image:
          json['images'][0]['image'] ?? 'public/Uploads/Images/Company/sh.jpg',
      category: json['category'],
      companyId: json['company']['id'],
      companyName: json['company']['name'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
