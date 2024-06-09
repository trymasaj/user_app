import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:masaj/features/book_service/data/models/booking_model/payment.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/book_service/enums/booking_status.dart';
import 'package:masaj/features/book_service/enums/payment_status.dart';
import 'package:masaj/features/bookings_tab/data/models/review_reponse.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';

import 'address.dart';
import 'member.dart';
import 'service.dart';

enum PaymentStatusPaidOrNotPaid { notPaid, paid }

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
  num? subtotal;
  num? membershipDiscountPercentage;
  num? userDiscountPercentage;
  num? discountedAmount;
  num? vatAmount;
  num? grandTotal;
  DateTime? bookingDate;
  PaymentStatusPaidOrNotPaid? paymentStatus;
  bool? isFreeBooking;
  List<AddonModel>? addons;
  BookingStatus? bookingStatus;
  String? totalDuration;
  String? bufferDuration;
  Service? service;
  List<Member>? members;
  Therapist? therapist;
  Address? address;
  Payment? payment;
  BookingModel({
    this.bookingId,
    this.countryId,
    this.review,
    this.addons,
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
    this.payment,
  });
  final ReviewModel? review;

  BookingModel copyWith({
    ValueGetter<int?>? bookingId,
    ValueGetter<int?>? countryId,
    ValueGetter<List<AddonModel>?>? addons,
    ValueGetter<int?>? therapistId,
    ValueGetter<int?>? serviceId,
    ValueGetter<int?>? customerId,
    ValueGetter<int?>? servicePrice,
    ValueGetter<ReviewModel?>? review,
    ValueGetter<int?>? serviceDurationId,
    ValueGetter<String?>? serviceTotalDuration,
    ValueGetter<List<int>?>? focusAreas,
    ValueGetter<String?>? focusAreasStr,
    ValueGetter<num?>? subtotal,
    ValueGetter<num?>? membershipDiscountPercentage,
    ValueGetter<num?>? userDiscountPercentage,
    ValueGetter<num?>? discountedAmount,
    ValueGetter<num?>? vatAmount,
    ValueGetter<num?>? grandTotal,
    ValueGetter<DateTime?>? bookingDate,
    ValueGetter<PaymentStatusPaidOrNotPaid?>? paymentStatus,
    ValueGetter<bool?>? isFreeBooking,
    ValueGetter<BookingStatus?>? bookingStatus,
    ValueGetter<String?>? totalDuration,
    ValueGetter<String?>? bufferDuration,
    ValueGetter<Service?>? service,
    ValueGetter<List<Member>?>? members,
    ValueGetter<Therapist?>? therapist,
    ValueGetter<Address?>? address,
    ValueGetter<Payment?>? payment,
  }) {
    return BookingModel(
      bookingId: bookingId != null ? bookingId() : this.bookingId,
      review: review != null ? review() : this.review,
      addons: addons != null ? addons() : this.addons,
      countryId: countryId != null ? countryId() : this.countryId,
      therapistId: therapistId != null ? therapistId() : this.therapistId,
      serviceId: serviceId != null ? serviceId() : this.serviceId,
      customerId: customerId != null ? customerId() : this.customerId,
      servicePrice: servicePrice != null ? servicePrice() : this.servicePrice,
      serviceDurationId: serviceDurationId != null
          ? serviceDurationId()
          : this.serviceDurationId,
      serviceTotalDuration: serviceTotalDuration != null
          ? serviceTotalDuration()
          : this.serviceTotalDuration,
      focusAreas: focusAreas != null ? focusAreas() : this.focusAreas,
      focusAreasStr:
          focusAreasStr != null ? focusAreasStr() : this.focusAreasStr,
      subtotal: subtotal != null ? subtotal() : this.subtotal,
      membershipDiscountPercentage: membershipDiscountPercentage != null
          ? membershipDiscountPercentage()
          : this.membershipDiscountPercentage,
      userDiscountPercentage: userDiscountPercentage != null
          ? userDiscountPercentage()
          : this.userDiscountPercentage,
      discountedAmount:
          discountedAmount != null ? discountedAmount() : this.discountedAmount,
      vatAmount: vatAmount != null ? vatAmount() : this.vatAmount,
      grandTotal: grandTotal != null ? grandTotal() : this.grandTotal,
      bookingDate: bookingDate != null ? bookingDate() : this.bookingDate,
      paymentStatus:
          paymentStatus != null ? paymentStatus() : this.paymentStatus,
      isFreeBooking:
          isFreeBooking != null ? isFreeBooking() : this.isFreeBooking,
      bookingStatus:
          bookingStatus != null ? bookingStatus() : this.bookingStatus,
      totalDuration:
          totalDuration != null ? totalDuration() : this.totalDuration,
      bufferDuration:
          bufferDuration != null ? bufferDuration() : this.bufferDuration,
      service: service != null ? service() : this.service,
      members: members != null ? members() : this.members,
      therapist: therapist != null ? therapist() : this.therapist,
      address: address != null ? address() : this.address,
      payment: payment != null ? payment() : this.payment,
    );
  }

  String get durationInMinutes {
    if (totalDuration == null) return '0';
    return totalDuration!.split(':').length > 2
        ? (int.parse(totalDuration!.split(':')[0]) * 60 +
                int.parse(totalDuration!.split(':')[1]))
            .toString()
        : totalDuration!.split(':')[1];
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'countryId': countryId,
      'therapistId': therapistId,
      'serviceId': serviceId,
      'customerId': customerId,
      "bookingReview": review?.toMap(),
      'addons': addons?.map((x) => x.toMap()).toList(),
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
      'bookingDate': bookingDate?.millisecondsSinceEpoch,
      'paymentStatus': paymentStatus?.index,
      'isFreeBooking': isFreeBooking,
      'bookingStatus': bookingStatus?.index,
      'totalDuration': totalDuration,
      'bufferDuration': bufferDuration,
      'service': service?.toMap(),
      'members': members?.map((x) => x.toMap()).toList(),
      'therapist': therapist?.toMap(),
      'address': address?.toMap(),
      'payment': payment?.toMap(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    print('''
_______________________
addons  ${map['addons']}
_______________________

''');
    return BookingModel(
      bookingId: map['bookingId']?.toInt(),
      addons: map['addons'] == null
          ? null
          : List<AddonModel>.from(
              map['addons']?.map((x) => AddonModel.fromMap(x))),
      countryId: map['countryId']?.toInt(),
      review: map['bookingReview'] != null
          ? ReviewModel.fromMap(map['bookingReview'])
          : null,
      therapistId: map['therapistId']?.toInt(),
      serviceId: map['serviceId']?.toInt(),
      customerId: map['customerId']?.toInt(),
      servicePrice: map['servicePrice']?.toInt(),
      serviceDurationId: map['serviceDurationId']?.toInt(),
      serviceTotalDuration: map['serviceTotalDuration'],
      focusAreas: List<int>.from(map['focusAreas']),
      focusAreasStr: map['focusAreasStr'],
      subtotal: map['subtotal'],
      membershipDiscountPercentage: map['membershipDiscountPercentage'],
      userDiscountPercentage: map['userDiscountPercentage'],
      discountedAmount: map['discountedAmount'],
      vatAmount: map['vatAmount'],
      grandTotal: map['grandTotal'],
      bookingDate: map['bookingDate'] != null
          ? DateTime.parse(map['bookingDate'])
          : null,
      paymentStatus: map['paymentStatus'] != null
          ? PaymentStatusPaidOrNotPaid.values[map['paymentStatus']]
          : null,
      isFreeBooking: map['isFreeBooking'],
      bookingStatus: map['bookingStatus'] != null
          ? BookingStatus.values[map['bookingStatus']]
          : null,
      totalDuration: map['totalDuration'],
      bufferDuration: map['bufferDuration'],
      service: map['service'] != null ? Service.fromMap(map['service']) : null,
      members: map['members'] != null
          ? List<Member>.from(map['members']?.map((x) => Member.fromMap(x)))
          : null,
      therapist:
          map['therapist'] != null ? Therapist.fromMap(map['therapist']) : null,
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      payment: map['payment'] != null ? Payment.fromMap(map['payment']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingModel(bookingId: $bookingId, countryId: $countryId, therapistId: $therapistId, serviceId: $serviceId, customerId: $customerId, servicePrice: $servicePrice, serviceDurationId: $serviceDurationId, serviceTotalDuration: $serviceTotalDuration, focusAreas: $focusAreas, focusAreasStr: $focusAreasStr, subtotal: $subtotal, membershipDiscountPercentage: $membershipDiscountPercentage, userDiscountPercentage: $userDiscountPercentage, discountedAmount: $discountedAmount, vatAmount: $vatAmount, grandTotal: $grandTotal, bookingDate: $bookingDate, paymentStatus: $paymentStatus, isFreeBooking: $isFreeBooking, bookingStatus: $bookingStatus, totalDuration: $totalDuration, bufferDuration: $bufferDuration, service: $service, members: $members, therapist: $therapist, address: $address, payment: $payment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingModel &&
        other.bookingId == bookingId &&
        other.addons == addons &&
        other.countryId == countryId &&
        other.therapistId == therapistId &&
        other.serviceId == serviceId &&
        other.customerId == customerId &&
        other.servicePrice == servicePrice &&
        other.serviceDurationId == serviceDurationId &&
        other.serviceTotalDuration == serviceTotalDuration &&
        listEquals(other.focusAreas, focusAreas) &&
        other.focusAreasStr == focusAreasStr &&
        other.subtotal == subtotal &&
        other.membershipDiscountPercentage == membershipDiscountPercentage &&
        other.userDiscountPercentage == userDiscountPercentage &&
        other.discountedAmount == discountedAmount &&
        other.vatAmount == vatAmount &&
        other.grandTotal == grandTotal &&
        other.bookingDate == bookingDate &&
        other.paymentStatus == paymentStatus &&
        other.isFreeBooking == isFreeBooking &&
        other.bookingStatus == bookingStatus &&
        other.totalDuration == totalDuration &&
        other.bufferDuration == bufferDuration &&
        other.service == service &&
        listEquals(other.members, members) &&
        other.therapist == therapist &&
        other.address == address &&
        other.payment == payment;
  }

  @override
  int get hashCode {
    return bookingId.hashCode ^
        countryId.hashCode ^
        therapistId.hashCode ^
        serviceId.hashCode ^
        addons.hashCode ^
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
        address.hashCode ^
        payment.hashCode;
  }

  SessionModel toSessionModel() {
    return SessionModel(
      address: address,
      id: bookingId!,
      serviceName: service?.title,
      serviceMediaUrl: service?.mediaUrl,
      therapistName: therapist?.fullName,
      members: members,
      bookingDate: bookingDate,
      totalDuration: totalDuration,
      countryId: countryId ?? 0,
      serviceId: serviceId,
      servicePrice: (servicePrice ?? 0).toDouble(),
    );
  }
}

//  {
//       "addonId": 2,
//       "serviceId": 1,
//       "countryId": 1,
//       "titleEn": "add new adddon",
//       "titleAr": "add new addon",
//       "title": "add new adddon",
//       "descriptionEn": "desc ",
//       "descriptionAr": "desc ar ",
//       "description": "desc ",
//       "duration": "00:20:00",
//       "price": 20
//     }
class AddonModel {
  final int? addonId;
  final int? serviceId;
  final int? countryId;
  final String? titleEn;
  final String? titleAr;
  final String? title;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? description;
  final String? duration;
  final int? price;
  AddonModel({
    this.addonId,
    this.serviceId,
    this.countryId,
    this.titleEn,
    this.titleAr,
    this.title,
    this.descriptionEn,
    this.descriptionAr,
    this.description,
    this.duration,
    this.price,
  });
  // from map
  factory AddonModel.fromMap(Map<String, dynamic> map) {
    return AddonModel(
      addonId: map['addonId']?.toInt(),
      serviceId: map['serviceId']?.toInt(),
      countryId: map['countryId']?.toInt(),
      titleEn: map['titleEn'],
      titleAr: map['titleAr'],
      title: map['title'],
      descriptionEn: map['descriptionEn'],
      descriptionAr: map['descriptionAr'],
      description: map['description'],
      duration: map['duration'],
      price: map['price']?.toInt(),
    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      'addonId': addonId,
      'serviceId': serviceId,
      'countryId': countryId,
      'titleEn': titleEn,
      'titleAr': titleAr,
      'title': title,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'description': description,
      'duration': duration,
      'price': price,
    };
  }
  // to json
}
