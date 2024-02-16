import 'dart:convert';

class Member {
  final String name, image, phone, gender;
  bool isSelected;

  Member(
      {required this.name,
      required this.image,
      required this.gender,
      required this.phone,
      this.isSelected = false});
  Member copyWith(
      {String? name,
      String? image,
      String? gender,
      String? phone,
      bool? isSelected}) {
    return Member(
        name: name ?? this.name,
        image: image ?? this.image,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        isSelected: isSelected ?? this.isSelected);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'phone': phone,
      'gender': gender,
    }..removeWhere((_, v) => v == null);
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
        name: map['name'],
        image: map['image'],
        gender: map['gender'],
        phone: map['phone'],
        isSelected: false);
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));

  @override
  String toString() =>
      'Member(name: $name, image: $image, gender: $gender, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Member &&
        other.name == name &&
        other.image == image &&
        other.phone == phone &&
        other.gender == gender &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode =>
      name.hashCode ^ phone.hashCode ^ gender.hashCode ^ image.hashCode;
}
