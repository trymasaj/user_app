// {
//     "id": 0,
//     "serviceNameEn": "string",
//     "serviceNameAr": "string",
//     "serviceName": "string",
//     "serviceMediaUrlEn": "string",
//     "serviceMediaUrlAr": "string",
//     "serviceMediaUrl": "string",
//     "therapistNameEn": "string",
//     "therapistNameAr": "string",
//     "therapistName": "string",
//     "bookingDate": "2024-04-06T13:39:05.998Z",
//     "totalDuration": "17:00:00",
//     "countryId": 0
//   }

import 'dart:convert';

class SessionModel {
  SessionModel({
    required this.id,
    this.serviceNameEn,
    this.serviceNameAr,
    this.serviceName,
    this.serviceMediaUrlEn,
    this.serviceMediaUrlAr,
    this.serviceMediaUrl,
    this.therapistNameEn,
    this.therapistNameAr,
    this.therapistName,
    this.bookingDate,
    this.totalDuration,
    required this.countryId,
    this.servicePrice,
    this.serviceId,
  });

  final int id;
  final String? serviceNameEn;
  final double? servicePrice;
  // sevice id
  final int? serviceId;
  final String? serviceNameAr;
  final String? serviceName;
  final String? serviceMediaUrlEn;
  final String? serviceMediaUrlAr;
  final String? serviceMediaUrl;
  final String? therapistNameEn;
  final String? therapistNameAr;
  final String? therapistName;
  final DateTime? bookingDate;
  final String? totalDuration;
  final int countryId;

  factory SessionModel.fromMap(Map<String, dynamic> json) => SessionModel(
        id: json["id"],
        serviceNameEn: json["serviceNameEn"],
        serviceNameAr: json["serviceNameAr"],
        serviceName: json["serviceName"],
        serviceMediaUrlEn: json["serviceMediaUrlEn"],
        serviceMediaUrlAr: json["serviceMediaUrlAr"],
        serviceMediaUrl: json["serviceMediaUrl"],
        therapistNameEn: json["therapistNameEn"],
        therapistNameAr: json["therapistNameAr"],
        therapistName: json["therapistName"],
        servicePrice:( json["servicePrice"] as num?)?.toDouble()  ,
        serviceId: json["serviceId"],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        totalDuration: json["totalDuration"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "serviceNameEn": serviceNameEn,
        "serviceNameAr": serviceNameAr,
        "serviceName": serviceName,
        "serviceMediaUrlEn": serviceMediaUrlEn,
        "serviceMediaUrlAr": serviceMediaUrlAr,
        "serviceMediaUrl": serviceMediaUrl,
        "therapistNameEn": therapistNameEn,
        "therapistNameAr": therapistNameAr,
        "therapistName": therapistName,
        "bookingDate":
            bookingDate?.toIso8601String(),
        "totalDuration": totalDuration,
        "countryId": countryId,
        "servicePrice": servicePrice,
        "serviceId": serviceId,
      };

  SessionModel copyWith({
    int? id,
    String? serviceNameEn,
    String? serviceNameAr,
    String? serviceName,
    String? serviceMediaUrlEn,
    String? serviceMediaUrlAr,
    String? serviceMediaUrl,
    String? therapistNameEn,
    String? therapistNameAr,
    String? therapistName,
    DateTime? bookingDate,
    String? totalDuration,
    int? countryId,
    int? serviceId,
    double? servicePrice,
  }) =>
      SessionModel(
        id: id ?? this.id,
        serviceNameEn: serviceNameEn ?? this.serviceNameEn,
        serviceNameAr: serviceNameAr ?? this.serviceNameAr,
        serviceName: serviceName ?? this.serviceName,
        serviceMediaUrlEn: serviceMediaUrlEn ?? this.serviceMediaUrlEn,
        serviceMediaUrlAr: serviceMediaUrlAr ?? this.serviceMediaUrlAr,
        serviceMediaUrl: serviceMediaUrl ?? this.serviceMediaUrl,
        therapistNameEn: therapistNameEn ?? this.therapistNameEn,
        therapistNameAr: therapistNameAr ?? this.therapistNameAr,
        therapistName: therapistName ?? this.therapistName,
        bookingDate: bookingDate ?? this.bookingDate,
        totalDuration: totalDuration ?? this.totalDuration,
        countryId: countryId ?? this.countryId,
        serviceId: serviceId ?? this.serviceId,
        servicePrice: servicePrice ?? this.servicePrice,
      );

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SessionModel(id: $id, serviceNameEn: $serviceNameEn, serviceNameAr: $serviceNameAr, serviceName: $serviceName, serviceMediaUrlEn: $serviceMediaUrlEn, serviceMediaUrlAr: $serviceMediaUrlAr, serviceMediaUrl: $serviceMediaUrl, therapistNameEn: $therapistNameEn, therapistNameAr: $therapistNameAr, therapistName: $therapistName, bookingDate: $bookingDate, totalDuration: $totalDuration, countryId: $countryId)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionModel &&
        other.id == id &&
        other.serviceNameEn == serviceNameEn &&
        other.serviceNameAr == serviceNameAr &&
        other.serviceName == serviceName &&
        other.serviceMediaUrlEn == serviceMediaUrlEn &&
        other.serviceMediaUrlAr == serviceMediaUrlAr &&
        other.serviceMediaUrl == serviceMediaUrl &&
        other.therapistNameEn == therapistNameEn &&
        other.therapistNameAr == therapistNameAr &&
        other.therapistName == therapistName &&
        other.bookingDate == bookingDate &&
        other.totalDuration == totalDuration &&
        other.servicePrice == servicePrice &&
        other.serviceId == serviceId &&
        other.countryId == countryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceNameEn.hashCode ^
        serviceNameAr.hashCode ^
        serviceName.hashCode ^
        serviceMediaUrlEn.hashCode ^
        serviceMediaUrlAr.hashCode ^
        serviceMediaUrl.hashCode ^
        therapistNameEn.hashCode ^
        therapistNameAr.hashCode ^
        therapistName.hashCode ^
        bookingDate.hashCode ^
        totalDuration.hashCode ^
        servicePrice.hashCode ^
        serviceId.hashCode ^
        countryId.hashCode;
  }
}
