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

import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/features/book_service/data/models/booking_model/address.dart';
import 'package:masaj/features/book_service/data/models/booking_model/member.dart';
import 'package:masaj/main.dart';

class SessionModel {
  SessionModel(
      {required this.id,
      this.serviceNameEn,
      this.serviceNameAr,
      this.serviceName,
      this.serviceMediaUrlEn,
      this.serviceMediaUrlAr,
      this.serviceMediaUrl,
      this.therapistNameEn,
      this.therapistNameAr,
      this.address,
      this.therapistName,
      this.bookingDate,
      this.totalDuration,
      required this.countryId,
      this.servicePrice,
      this.serviceId,
      this.members});

  final List<Member>? members;

  String get durationInMinutes {
    if (totalDuration == null) return '0';
    return totalDuration!.split(':').length > 2
        ? (int.parse(totalDuration!.split(':')[0]) * 60 +
                int.parse(totalDuration!.split(':')[1]))
            .toString()
        : totalDuration!.split(':')[1];
  }

  String get durationInHours {
    if (totalDuration == null) return '0';
    return totalDuration!.split(':').length > 2
        ? (int.parse(totalDuration!.split(':')[0]) * 60 +
                int.parse(totalDuration!.split(':')[1]))
            .toString()
        : totalDuration!.split(':')[0];
  }

  int get durationInMinutesInt => int.parse(durationInMinutes);

  String get formattedString {
    if (totalDuration == null) return '0';
    // if duration hourse is 0 return minutes if not return hours and minutes if minutes is not 0 if not return hours
    final hourse = int.parse(totalDuration!.split(':')[0]);
    final minutes = int.parse(totalDuration!.split(':')[1]);
    if (hourse == 0) {
      return '$minutes';
    }
    if (minutes == 0) {
      return '$hourse';
    }
    return '$hourse:$minutes';
  }

  String get unit {
    if (totalDuration == null) return 'Minutes';
    final hourse = int.parse(totalDuration!.split(':')[0]);
    final minutes = int.parse(totalDuration!.split(':')[1]);
    if (hourse == 0) {
      return 'Minutes';
    }
    if (minutes == 0) {
      return 'Hours';
    }
    return 'Hours';
  }

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
  final Address? address;

  final int countryId;
  // 10 AM -12 PM
  String get timeString {
    if (bookingDate == null) return '';
    return '${bookingDate!.timeString} - ${(bookingDate!.add(Duration(minutes: durationInMinutesInt))).timeString}';
  }

  factory SessionModel.fromMap(Map<String, dynamic> json) => SessionModel(
        id: json["id"],
        serviceNameEn: json["serviceNameEn"],
        serviceNameAr: json["serviceNameAr"],
        address:
            json['address'] == null ? null : Address.fromMap(json['address']),
        serviceName: json["serviceName"],
        serviceMediaUrlEn: json["serviceMediaUrlEn"],
        serviceMediaUrlAr: json["serviceMediaUrlAr"],
        serviceMediaUrl: json["serviceMediaUrl"],
        therapistNameEn: json["therapistNameEn"],
        therapistNameAr: json["therapistNameAr"],
        therapistName: json["therapistName"],
        servicePrice: (json["servicePrice"] as num?)?.toDouble(),
        serviceId: json["serviceId"],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        totalDuration: json["totalDuration"],
        countryId: json["countryId"],
        members: json['members'] == null
            ? null
            : List<Member>.from(json['members'].map((x) => Member.fromMap(x))),
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
        "bookingDate": bookingDate?.toIso8601String(),
        "totalDuration": totalDuration,
        "countryId": countryId,
        "servicePrice": servicePrice,
        "serviceId": serviceId,
        'address': address?.toMap(),
        "members": members == null
            ? null
            : List<dynamic>.from(members!.map((x) => x.toMap())),
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
    List<Member>? members,
    Address? address,
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
        members: members ?? this.members,
        address: address ?? this.address,
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
        other.countryId == countryId &&
        address == other.address &&
        (other.members == members);
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
        countryId.hashCode ^
        address.hashCode ^
        members.hashCode;
  }
}

extension DateStrings on DateTime {
  // week day like sat sun mon by local by intl
  String get weekDayString {
    final local = EasyLocalization.of(navigatorKey!.currentContext!)!
        .currentLocale
        ?.languageCode;
    return DateFormat.EEEE(local).format(this);
  }

  String get monthString {
    final local = EasyLocalization.of(navigatorKey!.currentContext!)!
        .currentLocale
        ?.languageCode;
    return DateFormat.MMMM(local).format(this);
  }

// am to pm like 10 Am to Pm
  String get timeString {
    final local = EasyLocalization.of(navigatorKey!.currentContext!)!
        .currentLocale
        ?.languageCode;
    return DateFormat.jm(local).format(this);
  }
}
