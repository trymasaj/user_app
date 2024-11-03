import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class MedicalCondition {
  int? id;
  String? nameEn;
  String? nameAr;
  MedicalCondition({
    this.id,
    this.nameEn,
    this.nameAr,
  });

  MedicalCondition copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? nameEn,
    ValueGetter<String?>? nameAr,
  }) {
    return MedicalCondition(
      id: id != null ? id() : this.id,
      nameEn: nameEn != null ? nameEn() : this.nameEn,
      nameAr: nameAr != null ? nameAr() : this.nameAr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
    };
  }

  factory MedicalCondition.fromMap(Map<String, dynamic> map) {
    return MedicalCondition(
      id: map['id']?.toInt(),
      nameEn: map['nameEn'],
      nameAr: map['nameAr'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalCondition.fromJson(String source) =>
      MedicalCondition.fromMap(json.decode(source));

  @override
  String toString() =>
      'MedicalCondition(id: $id, nameEn: $nameEn, nameAr: $nameAr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicalCondition &&
        other.id == id &&
        other.nameEn == nameEn &&
        other.nameAr == nameAr;
  }

  @override
  int get hashCode => id.hashCode ^ nameEn.hashCode ^ nameAr.hashCode;

  String localizedName(BuildContext context) {
    return context.locale.languageCode == 'ar'? this.nameAr??'' : this.nameEn ?? '';
  }
}
