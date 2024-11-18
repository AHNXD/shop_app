class HomeCategoryModel {
  final num id;
  final String name;
  final String image;

  HomeCategoryModel({required this.id,required this.name, required this.image});
  factory HomeCategoryModel.fromJson(json) {
    return HomeCategoryModel(
        id: json['id'], image: json['image']??'', name: json['name']);
  }
}
