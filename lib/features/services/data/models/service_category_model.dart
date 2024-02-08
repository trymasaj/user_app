import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceCategory extends Equatable {
  final int? id;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? nameEn;
  final String? nameAr;
  final String? image;
  final String? name;

  const ServiceCategory(
      {this.id,
      this.descriptionEn,
      this.descriptionAr,
      this.nameEn,
      this.nameAr,
      this.image,
      this.name});

  factory ServiceCategory.fromMap(Map<String, dynamic> json) {
    return ServiceCategory(
        id: json['id'],
        descriptionEn: json['descriptionEn'],
        descriptionAr: json['descriptionAr'],
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        image: json['image'],
        name: json['name']);
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'image': image,
    }..removeWhere((key, value) => value == null);
  }

  // copy with
  ServiceCategory copyWith(
      {int? id,
      String? descriptionEn,
      String? descriptionAr,
      String? nameEn,
      String? nameAr,
      String? image,
      String? name}) {
    return ServiceCategory(
        id: id ?? this.id,
        descriptionEn: descriptionEn ?? this.descriptionEn,
        descriptionAr: descriptionAr ?? this.descriptionAr,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        image: image ?? this.image,
        name: name ?? this.name);
  }

  factory ServiceCategory.fromJson(String source) =>
      ServiceCategory.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props =>
      [id, descriptionEn, descriptionAr, nameEn, nameAr, image, name];
}
