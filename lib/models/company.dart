class Company {
  bool? success;
  String? message;
  List<CompanyData>? data;

  Company({this.success, this.message, this.data});

  Company.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(CompanyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyData {
  int? id;
  String? name;
  String? image;
  String? size;
  String? city;
  String? manager;
  int? cityId;

  CompanyData(
      {this.id,
      this.name,
      this.image,
      this.size,
      this.city,
      this.manager,
      this.cityId});

  CompanyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    size = json['size'];
    city = json['city'];
    manager = json['manager'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['size'] = size;
    data['city'] = city;
    data['manager'] = manager;
    data['city_id'] = cityId;
    return data;
  }
}
