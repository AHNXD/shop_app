class CompanyModel {
  final num id;
  final String name;
  final String image;

  CompanyModel({required this.id, required this.name, required this.image});
  factory CompanyModel.fromJson(json) {
    return CompanyModel(
        id: json['id'], name: json['name'], image: json['image']);
  }
}
