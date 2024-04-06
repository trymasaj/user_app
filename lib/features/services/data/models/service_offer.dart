import 'dart:convert';

class ServiceOffer {
  ServiceOffer({
    required this.serviceId,
    this.serviceDurationId,
    this.mainImage,
    this.mainImageEn,
    this.mainImageAr,
    this.title,
    this.titleEn,
    this.titleAr,
    this.description,
    this.descriptionEn,
    this.descriptionAr,
    this.originalPrice,
    this.discountedPrice,
  });

  final int serviceId;
  final int? serviceDurationId;
  final String? mainImage;
  final String? mainImageEn;
  final String? mainImageAr;
  final String? title;
  final String? titleEn;
  final String? titleAr;
  final String? description;
  final String? descriptionEn;
  final String? descriptionAr;
  final double? originalPrice;
  final double? discountedPrice;

  factory ServiceOffer.fromMap(Map<String, dynamic> json) => ServiceOffer(
        serviceId: json["serviceId"],
        serviceDurationId: json["serviceDurationId"],
        mainImage: json["mainImage"],
        mainImageEn: json["mainImageEn"],
        mainImageAr: json["mainImageAr"],
        title: json["title"],
        titleEn: json["titleEn"],
        titleAr: json["titleAr"],
        description: json["description"],
        descriptionEn: json["descriptionEn"],
        descriptionAr: json["descriptionAr"],
        originalPrice: (json["originalPrice"] as num?)?.toDouble(),
        discountedPrice: (json["discountedPrice"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "serviceId": serviceId,
        "serviceDurationId": serviceDurationId,
        "mainImage": mainImage,
        "mainImageEn": mainImageEn,
        "mainImageAr": mainImageAr,
        "title": title,
        "titleEn": titleEn,
        "titleAr": titleAr,
        "description": description,
        "descriptionEn": descriptionEn,
        "descriptionAr": descriptionAr,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
      };
  // from json string

  factory ServiceOffer.fromJson(String source) =>
      ServiceOffer.fromMap(json.decode(source));
  // to json
  String toJson() => json.encode(toMap());

  // copy with
  ServiceOffer copyWith({
    int? serviceId,
    int? serviceDurationId,
    String? mainImage,
    String? mainImageEn,
    String? mainImageAr,
    String? title,
    String? titleEn,
    String? titleAr,
    String? description,
    String? descriptionEn,
    String? descriptionAr,
    double? originalPrice,
    double? discountedPrice,
  }) =>
      ServiceOffer(
        serviceId: serviceId ?? this.serviceId,
        serviceDurationId: serviceDurationId ?? this.serviceDurationId,
        mainImage: mainImage ?? this.mainImage,
        mainImageEn: mainImageEn ?? this.mainImageEn,
        mainImageAr: mainImageAr ?? this.mainImageAr,
        title: title ?? this.title,
        titleEn: titleEn ?? this.titleEn,
        titleAr: titleAr ?? this.titleAr,
        description: description ?? this.description,
        descriptionEn: descriptionEn ?? this.descriptionEn,
        descriptionAr: descriptionAr ?? this.descriptionAr,
        originalPrice: originalPrice ?? this.originalPrice,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  @override
  String toString() {
    return 'ServiceOffer(serviceId: $serviceId, serviceDurationId: $serviceDurationId, mainImage: $mainImage, mainImageEn: $mainImageEn, mainImageAr: $mainImageAr, title: $title, titleEn: $titleEn, titleAr: $titleAr, description: $description, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, originalPrice: $originalPrice, discountedPrice: $discountedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceOffer &&
        other.serviceId == serviceId &&
        other.serviceDurationId == serviceDurationId &&
        other.mainImage == mainImage &&
        other.mainImageEn == mainImageEn &&
        other.mainImageAr == mainImageAr &&
        other.title == title &&
        other.titleEn == titleEn &&
        other.titleAr == titleAr &&
        other.description == description &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.originalPrice == originalPrice &&
        other.discountedPrice == discountedPrice;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        serviceDurationId.hashCode ^
        mainImage.hashCode ^
        mainImageEn.hashCode ^
        mainImageAr.hashCode ^
        title.hashCode ^
        titleEn.hashCode ^
        titleAr.hashCode ^
        description.hashCode ^
        descriptionEn.hashCode ^
        descriptionAr.hashCode ^
        originalPrice.hashCode ^
        discountedPrice.hashCode;
  }
}
