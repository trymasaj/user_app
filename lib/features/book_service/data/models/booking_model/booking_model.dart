import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';

import 'address.dart';
import 'member.dart';
import 'service.dart';
import 'therapist.dart';

class BookingModel {
  int? bookingId;
  int? countryId;
  int? therapistId;
  int? serviceId;
  int? customerId;
  int? servicePrice;
  int? serviceDurationId;
  String? serviceTotalDuration;
  List<int>? focusAreas;
  String? focusAreasStr;
  int? subtotal;
  int? membershipDiscountPercentage;
  int? userDiscountPercentage;
  int? discountedAmount;
  int? vatAmount;
  int? grandTotal;
  DateTime? bookingDate;
  int? paymentStatus;
  bool? isFreeBooking;
  int? bookingStatus;
  String? totalDuration;
  String? bufferDuration;
  Service? service;
  List<Member>? members;
  Therapist? therapist;
  Address? address;

  BookingModel({
    this.bookingId,
    this.countryId,
    this.therapistId,
    this.serviceId,
    this.customerId,
    this.servicePrice,
    this.serviceDurationId,
    this.serviceTotalDuration,
    this.focusAreas,
    this.focusAreasStr,
    this.subtotal,
    this.membershipDiscountPercentage,
    this.userDiscountPercentage,
    this.discountedAmount,
    this.vatAmount,
    this.grandTotal,
    this.bookingDate,
    this.paymentStatus,
    this.isFreeBooking,
    this.bookingStatus,
    this.totalDuration,
    this.bufferDuration,
    this.service,
    this.members,
    this.therapist,
    this.address,
  });

  @override
  String toString() {
    return 'BookingModel(bookingId: $bookingId, countryId: $countryId, therapistId: $therapistId, serviceId: $serviceId, customerId: $customerId, servicePrice: $servicePrice, serviceDurationId: $serviceDurationId, serviceTotalDuration: $serviceTotalDuration, focusAreas: $focusAreas, focusAreasStr: $focusAreasStr, subtotal: $subtotal, membershipDiscountPercentage: $membershipDiscountPercentage, userDiscountPercentage: $userDiscountPercentage, discountedAmount: $discountedAmount, vatAmount: $vatAmount, grandTotal: $grandTotal, bookingDate: $bookingDate, paymentStatus: $paymentStatus, isFreeBooking: $isFreeBooking, bookingStatus: $bookingStatus, totalDuration: $totalDuration, bufferDuration: $bufferDuration, service: $service, members: $members, therapist: $therapist, address: $address)';
  }

  factory BookingModel.fromMap(Map<String, dynamic> data) => BookingModel(
        bookingId: data['bookingId'] as int?,
        countryId: data['countryId'] as int?,
        therapistId: data['therapistId'] as int?,
        serviceId: data['serviceId'] as int?,
        customerId: data['customerId'] as int?,
        servicePrice: data['servicePrice'] as int?,
        serviceDurationId: data['serviceDurationId'] as int?,
        serviceTotalDuration: data['serviceTotalDuration'] as String?,
        focusAreas: data['focusAreas'] as List<int>?,
        focusAreasStr: data['focusAreasStr'] as String?,
        subtotal: data['subtotal'] as int?,
        membershipDiscountPercentage:
            data['membershipDiscountPercentage'] as int?,
        userDiscountPercentage: data['userDiscountPercentage'] as int?,
        discountedAmount: data['discountedAmount'] as int?,
        vatAmount: data['vatAmount'] as int?,
        grandTotal: data['grandTotal'] as int?,
        bookingDate: data['bookingDate'] == null
            ? null
            : DateTime.parse(data['bookingDate'] as String),
        paymentStatus: data['paymentStatus'] as int?,
        isFreeBooking: data['isFreeBooking'] as bool?,
        bookingStatus: data['bookingStatus'] as int?,
        totalDuration: data['totalDuration'] as String?,
        bufferDuration: data['bufferDuration'] as String?,
        service: data['service'] == null
            ? null
            : Service.fromMap(data['service'] as Map<String, dynamic>),
        members: (data['members'] as List<dynamic>?)
            ?.map((e) => Member.fromMap(e as Map<String, dynamic>))
            .toList(),
        therapist: data['therapist'] == null
            ? null
            : Therapist.fromMap(data['therapist'] as Map<String, dynamic>),
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'bookingId': bookingId,
        'countryId': countryId,
        'therapistId': therapistId,
        'serviceId': serviceId,
        'customerId': customerId,
        'servicePrice': servicePrice,
        'serviceDurationId': serviceDurationId,
        'serviceTotalDuration': serviceTotalDuration,
        'focusAreas': focusAreas,
        'focusAreasStr': focusAreasStr,
        'subtotal': subtotal,
        'membershipDiscountPercentage': membershipDiscountPercentage,
        'userDiscountPercentage': userDiscountPercentage,
        'discountedAmount': discountedAmount,
        'vatAmount': vatAmount,
        'grandTotal': grandTotal,
        'bookingDate': bookingDate?.toIso8601String(),
        'paymentStatus': paymentStatus,
        'isFreeBooking': isFreeBooking,
        'bookingStatus': bookingStatus,
        'totalDuration': totalDuration,
        'bufferDuration': bufferDuration,
        'service': service?.toMap(),
        'members': members?.map((e) => e.toMap()).toList(),
        'therapist': therapist?.toMap(),
        'address': address?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookingModel].
  factory BookingModel.fromJson(String data) {
    return BookingModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookingModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BookingModel copyWith({
    int? bookingId,
    int? countryId,
    int? therapistId,
    int? serviceId,
    int? customerId,
    int? servicePrice,
    int? serviceDurationId,
    String? serviceTotalDuration,
    List<int>? focusAreas,
    String? focusAreasStr,
    int? subtotal,
    int? membershipDiscountPercentage,
    int? userDiscountPercentage,
    int? discountedAmount,
    int? vatAmount,
    int? grandTotal,
    DateTime? bookingDate,
    int? paymentStatus,
    bool? isFreeBooking,
    int? bookingStatus,
    String? totalDuration,
    String? bufferDuration,
    Service? service,
    List<Member>? members,
    Therapist? therapist,
    Address? address,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      countryId: countryId ?? this.countryId,
      therapistId: therapistId ?? this.therapistId,
      serviceId: serviceId ?? this.serviceId,
      customerId: customerId ?? this.customerId,
      servicePrice: servicePrice ?? this.servicePrice,
      serviceDurationId: serviceDurationId ?? this.serviceDurationId,
      serviceTotalDuration: serviceTotalDuration ?? this.serviceTotalDuration,
      focusAreas: focusAreas ?? this.focusAreas,
      focusAreasStr: focusAreasStr ?? this.focusAreasStr,
      subtotal: subtotal ?? this.subtotal,
      membershipDiscountPercentage:
          membershipDiscountPercentage ?? this.membershipDiscountPercentage,
      userDiscountPercentage:
          userDiscountPercentage ?? this.userDiscountPercentage,
      discountedAmount: discountedAmount ?? this.discountedAmount,
      vatAmount: vatAmount ?? this.vatAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      bookingDate: bookingDate ?? this.bookingDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isFreeBooking: isFreeBooking ?? this.isFreeBooking,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      totalDuration: totalDuration ?? this.totalDuration,
      bufferDuration: bufferDuration ?? this.bufferDuration,
      service: service ?? this.service,
      members: members ?? this.members,
      therapist: therapist ?? this.therapist,
      address: address ?? this.address,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BookingModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      bookingId.hashCode ^
      countryId.hashCode ^
      therapistId.hashCode ^
      serviceId.hashCode ^
      customerId.hashCode ^
      servicePrice.hashCode ^
      serviceDurationId.hashCode ^
      serviceTotalDuration.hashCode ^
      focusAreas.hashCode ^
      focusAreasStr.hashCode ^
      subtotal.hashCode ^
      membershipDiscountPercentage.hashCode ^
      userDiscountPercentage.hashCode ^
      discountedAmount.hashCode ^
      vatAmount.hashCode ^
      grandTotal.hashCode ^
      bookingDate.hashCode ^
      paymentStatus.hashCode ^
      isFreeBooking.hashCode ^
      bookingStatus.hashCode ^
      totalDuration.hashCode ^
      bufferDuration.hashCode ^
      service.hashCode ^
      members.hashCode ^
      therapist.hashCode ^
      address.hashCode;
}
