import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:masaj/core/domain/enums/gender.dart';

class GiftModel {
  int? id;
  int? customerId;
  String? name;
  String? countryCode;
  String? phone;
  Gender? gender;
  String? image;
  bool? isSelected = false;

  GiftModel(
      {this.id,
      this.customerId,
      this.name,
      this.countryCode,
      this.phone,
      this.gender,
      this.isSelected,
      this.image});

  String toJson() => json.encode(toMap());

  factory GiftModel.fromJson(String source) =>
      GiftModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GiftModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    name = json['name'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    gender = Gender.values.firstWhereOrNull((e) => e.id == json['gender']);
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerId'] = customerId;
    data['name'] = name;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['gender'] = gender?.id;
    data['image'] = image;
    return data;
  }

  @override
  String toString() =>
      'MemberModel(id: $id , name: $name , image: $image , phone: $phone , gender: $gender, countryCode: $countryCode , customerId: $customerId)';

  @override
  bool operator ==(covariant GiftModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerId == customerId &&
        other.phone == phone &&
        other.image == image &&
        other.gender == gender &&
        other.countryCode == countryCode &&
        other.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      gender.hashCode ^
      countryCode.hashCode ^
      customerId.hashCode;
}
