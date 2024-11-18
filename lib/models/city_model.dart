class CityModel {
  final int id;
  final String name;
  final List<Address> addresses;

  CityModel({required this.id, required this.name, required this.addresses});
  factory CityModel.fromJson(var json) {
    List<Address> tempAddresses = [];
    if (json['addresses'] != null) {
      json['addresses'].forEach((v) {
        tempAddresses.add(Address.fromJson(v));
      });
    }
    return CityModel(
        id: json['id'], name: json['name'], addresses: tempAddresses);
  }
}

class Address {
  final int id;
  final int cityId;
  final String name;

  Address({required this.id, required this.cityId, required this.name});
  factory Address.fromJson(var json) {
    return Address(id: json['id'], cityId: json['city_id'], name: json['name']);
  }
}
