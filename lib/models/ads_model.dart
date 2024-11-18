class AdsModel {
  final num id;
  final String image;
  final num companyId;

  AdsModel({required this.id, required this.image, required this.companyId});
  factory AdsModel.fromJson(json) {
    return AdsModel(
        id: json['id'], image: json['image'], companyId: json['company_id']);
  }
}
