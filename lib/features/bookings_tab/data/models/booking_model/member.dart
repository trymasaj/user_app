import 'dart:convert';

import 'package:collection/collection.dart';

class Member {
  int? memberId;
  String? name;
  String? countryCode;
  String? phone;
  int? gender;
  String? image;
  bool? isSelf;

  Member({
    this.memberId,
    this.name,
    this.countryCode,
    this.phone,
    this.gender,
    this.image,
    this.isSelf,
  });

  @override
  String toString() {
    return 'Member(memberId: $memberId, name: $name, countryCode: $countryCode, phone: $phone, gender: $gender, image: $image, isSelf: $isSelf)';
  }

  factory Member.fromMap(Map<String, dynamic> data) => Member(
        memberId: data['memberId'] as int?,
        name: data['name'] as String?,
        countryCode: data['countryCode'] as String?,
        phone: data['phone'] as String?,
        gender: data['gender'] as int?,
        image: data['image'] as String?,
        isSelf: data['isSelf'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'memberId': memberId,
        'name': name,
        'countryCode': countryCode,
        'phone': phone,
        'gender': gender,
        'image': image,
        'isSelf': isSelf,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Member].
  factory Member.fromJson(String data) {
    return Member.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Member] to a JSON string.
  String toJson() => json.encode(toMap());

  Member copyWith({
    int? memberId,
    String? name,
    String? countryCode,
    String? phone,
    int? gender,
    String? image,
    bool? isSelf,
  }) {
    return Member(
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      isSelf: isSelf ?? this.isSelf,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Member) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      memberId.hashCode ^
      name.hashCode ^
      countryCode.hashCode ^
      phone.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      isSelf.hashCode;
}
