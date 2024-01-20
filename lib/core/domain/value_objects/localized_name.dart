class LocalizedName {
  final String nameEn, nameAr;

  LocalizedName({required this.nameEn, required this.nameAr});

  Map<String, dynamic> toMap() {
    return {
      'nameEn': this.nameEn,
      'nameAr': this.nameAr,
    };
  }

  factory LocalizedName.fromMap(Map<String, dynamic> map) {
    return LocalizedName(
      nameEn: map['nameEn'] as String,
      nameAr: map['nameAr'] as String,
    );
  }
}
