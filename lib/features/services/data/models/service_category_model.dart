import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:masaj/core/app_export.dart';

class ServiceCategory extends Equatable {
  final int id;
  final String descriptionEn;
  final String descriptionAr;
  final String nameEn;
  final String nameAr;
  final String image;

  // get name by locale
  String getName(BuildContext context) {
    return EasyLocalization.of(context)?.locale.languageCode == 'en'
        ? nameEn
        : nameAr;
  }

  const ServiceCategory({
    required this.id,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.nameEn,
    required this.nameAr,
    required this.image,
  });

  factory ServiceCategory.fromMap(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      descriptionEn: json['descriptionEn'],
      descriptionAr: json['descriptionAr'],
      nameEn: json['nameEn'],
      nameAr: json['nameAr'],
      image: json['image'],
    );
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
    };
  }

  // copy with
  ServiceCategory copyWith({
    int? id,
    String? descriptionEn,
    String? descriptionAr,
    String? nameEn,
    String? nameAr,
    String? image,
  }) {
    return ServiceCategory(
      id: id ?? this.id,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      image: image ?? this.image,
    );
  }

  factory ServiceCategory.fromJson(String source) =>
      ServiceCategory.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props =>
      [id, descriptionEn, descriptionAr, nameEn, nameAr, image];
}
