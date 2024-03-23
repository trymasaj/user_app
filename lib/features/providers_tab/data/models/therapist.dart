import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:masaj/features/address/domain/entities/country.dart';

class Therapist {
  final int? therapistId;
  final int? countryId;
  final String? fullNameEn;
  final String? fullNameAr;
  final String? fullName;
  final String? titleEn;
  final String? titleAr;
  final String? title;
  final String? aboutEn;
  final String? aboutAr;
  final String? about;
  final String? profileImage;
  final double? commission;
  final bool? homePageFeatured;
  final int? homePageSortKey;
  final double? rank;
  final bool? isActive;
  final bool? isFavourite;
  final List<TherapistService>? services;
  final List<Schedule>? schedule;
  final List<Review>? reviews;
  final Country? country;

  // copy with
  Therapist copyWith({
    int? therapistId,
    int? countryId,
    String? fullNameEn,
    String? fullNameAr,
    String? fullName,
    String? titleEn,
    String? titleAr,
    String? title,
    String? aboutEn,
    String? aboutAr,
    String? about,
    String? profileImage,
    double? commission,
    bool? homePageFeatured,
    int? homePageSortKey,
    double? rank,
    bool? isActive,
    bool? isFavourite,
    List<TherapistService>? services,
    List<Schedule>? schedule,
    List<Review>? reviews,
    Country? country,
  }) {
    return Therapist(
      therapistId: therapistId ?? this.therapistId,
      countryId: countryId ?? this.countryId,
      fullNameEn: fullNameEn ?? this.fullNameEn,
      fullNameAr: fullNameAr ?? this.fullNameAr,
      fullName: fullName ?? this.fullName,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      title: title ?? this.title,
      aboutEn: aboutEn ?? this.aboutEn,
      aboutAr: aboutAr ?? this.aboutAr,
      about: about ?? this.about,
      profileImage: profileImage ?? this.profileImage,
      commission: commission ?? this.commission,
      homePageFeatured: homePageFeatured ?? this.homePageFeatured,
      homePageSortKey: homePageSortKey ?? this.homePageSortKey,
      rank: rank ?? this.rank,
      isActive: isActive ?? this.isActive,
      isFavourite: isFavourite ?? this.isFavourite,
      services: services ?? this.services,
      schedule: schedule ?? this.schedule,
      reviews: reviews ?? this.reviews,
      country: country ?? this.country,
    );
  }

  Therapist({
    this.therapistId,
    this.countryId,
    this.fullNameEn,
    this.fullNameAr,
    this.fullName,
    this.titleEn,
    this.titleAr,
    this.title,
    this.aboutEn,
    this.aboutAr,
    this.about,
    this.profileImage,
    this.commission,
    this.homePageFeatured,
    this.homePageSortKey,
    this.rank,
    this.isActive,
    this.isFavourite,
    this.services,
    this.schedule,
    this.reviews,
    this.country,
  });

  factory Therapist.fromMap(Map<String, dynamic> json) {
    final String? fullNameEn = json['fullNameEn'] ?? json['therapistNameEn'];
    final String? fullNameAr = json['fullNameAr'] ?? json['therapistNameAr'];
    final String? fullName = json['fullName'] ?? json['therapistName'];

    return Therapist(
      therapistId: json['therapistId'],
      countryId: json['countryId'],
      fullNameEn: fullNameEn,
      fullNameAr: fullNameAr,
      fullName: fullName,
      titleEn: json['titleEn'],
      titleAr: json['titleAr'],
      title: json['title'],
      aboutEn: json['aboutEn'],
      aboutAr: json['aboutAr'],
      about: json['about'],
      profileImage: json['profileImage'],
      commission: json['commission'],
      homePageFeatured: json['homePageFeatured'],
      homePageSortKey: json['homePageSortKey'],
      rank: (json['rank'] as num).toDouble(),
      isActive: json['isActive'],
      isFavourite: json['isFavourite'],
      services: json['services'] == null
          ? null
          : List<TherapistService>.from(
              json['services']?.map((x) => TherapistService.fromMap(x))),
      schedule: json['schedule'] == null
          ? null
          : List<Schedule>.from(
              json['schedule']?.map((x) => Schedule.fromMap(x))),
      reviews: json['reviews'] == null
          ? null
          : List<Review>.from(json['reviews']?.map((x) => Review.fromMap(x))),
      country:
          json['country'] == null ? null : Country.fromMap(json['country']),
    );
  }

  factory Therapist.fromJson(String source) =>
      Therapist.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'therapistId': therapistId,
      'countryId': countryId,
      'fullNameEn': fullNameEn,
      'fullNameAr': fullNameAr,
      'fullName': fullName,
      'titleEn': titleEn,
      'titleAr': titleAr,
      'title': title,
      'aboutEn': aboutEn,
      'aboutAr': aboutAr,
      'about': about,
      'profileImage': profileImage,
      'commission': commission,
      'homePageFeatured': homePageFeatured,
      'homePageSortKey': homePageSortKey,
      'rank': rank,
      'isActive': isActive,
      'isFavourite': isFavourite,
      'services': services?.map((x) => x.toMap()).toList(),
      'schedule': schedule?.map((x) => x.toMap()).toList(),
      'reviews': reviews?.map((x) => x.toMap()).toList(),
      'country': country?.toMap(),
    };
  }

  @override
  int get hashCode =>
      therapistId.hashCode ^
      countryId.hashCode ^
      fullNameEn.hashCode ^
      fullNameAr.hashCode ^
      fullName.hashCode ^
      titleEn.hashCode ^
      titleAr.hashCode ^
      title.hashCode ^
      aboutEn.hashCode ^
      aboutAr.hashCode ^
      about.hashCode ^
      profileImage.hashCode ^
      commission.hashCode ^
      homePageFeatured.hashCode ^
      homePageSortKey.hashCode ^
      rank.hashCode ^
      isActive.hashCode ^
      isFavourite.hashCode ^
      services.hashCode ^
      schedule.hashCode ^
      reviews.hashCode ^
      country.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Therapist &&
        other.therapistId == therapistId &&
        other.countryId == countryId &&
        other.fullNameEn == fullNameEn &&
        other.fullNameAr == fullNameAr &&
        other.fullName == fullName &&
        other.titleEn == titleEn &&
        other.titleAr == titleAr &&
        other.title == title &&
        other.aboutEn == aboutEn &&
        other.aboutAr == aboutAr &&
        other.about == about &&
        other.profileImage == profileImage &&
        other.commission == commission &&
        other.homePageFeatured == homePageFeatured &&
        other.homePageSortKey == homePageSortKey &&
        other.rank == rank &&
        other.isActive == isActive &&
        other.isFavourite == isFavourite &&
        listEquals(other.services, services) &&
        listEquals(other.schedule, schedule) &&
        listEquals(other.reviews, reviews) &&
        other.country == country;
  }

  // toString method
  @override
  String toString() {
    return 'Therapist(therapistId: $therapistId, countryId: $countryId, fullNameEn: $fullNameEn, fullNameAr: $fullNameAr, fullName: $fullName, titleEn: $titleEn, titleAr: $titleAr, title: $title, aboutEn: $aboutEn, aboutAr: $aboutAr, about: $about, profileImage: $profileImage, commission: $commission, homePageFeatured: $homePageFeatured, homePageSortKey: $homePageSortKey, rank: $rank, isActive: $isActive, isFavourite: $isFavourite, services: $services, schedule: $schedule, reviews: $reviews, country: $country)';
  }
}

class TherapistService {
  final int? serviceId;
  final String? serviceTitleEn;
  final String? serviceTitleAr;

  TherapistService({
    this.serviceId,
    this.serviceTitleEn,
    this.serviceTitleAr,
  });

  factory TherapistService.fromMap(Map<String, dynamic> json) {
    return TherapistService(
      serviceId: json['serviceId'],
      serviceTitleEn: json['serviceTitleEn'],
      serviceTitleAr: json['serviceTitleAr'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceTitleEn': serviceTitleEn,
      'serviceTitleAr': serviceTitleAr,
    };
  }
}

class Schedule {
  final int? day;
  final String? dayName;
  final String? availableFrom;
  final String? availableTo;

  Schedule({
    this.day,
    this.dayName,
    this.availableFrom,
    this.availableTo,
  });

  factory Schedule.fromMap(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'],
      dayName: json['dayName'],
      availableFrom: json['availableFrom'],
      availableTo: json['availableTo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'dayName': dayName,
      'availableFrom': availableFrom,
      'availableTo': availableTo,
    };
  }
}

class Review {
  final int? reviewId;
  final int? bookingId;
  final int? customerId;
  final String? customerName;
  final int? rating;
  final String? customerOpinion;
  final String? improveServicesHint;
  final DateTime? reviewDate;
  final bool? isPublished;
  final int? sortKey;

  Review({
    this.reviewId,
    this.bookingId,
    this.customerId,
    this.customerName,
    this.rating,
    this.customerOpinion,
    this.improveServicesHint,
    this.reviewDate,
    this.isPublished,
    this.sortKey,
  });

  factory Review.fromMap(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'],
      bookingId: json['bookingId'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      rating: json['rating'],
      customerOpinion: json['customerOpinion'],
      improveServicesHint: json['improveServicesHint'],
      reviewDate: DateTime.parse(json['reviewDate']),
      isPublished: json['isPublished'],
      sortKey: json['sortKey'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'bookingId': bookingId,
      'customerId': customerId,
      'customerName': customerName,
      'rating': rating,
      'customerOpinion': customerOpinion,
      'improveServicesHint': improveServicesHint,
      'reviewDate': reviewDate?.toIso8601String(),
      'isPublished': isPublished,
      'sortKey': sortKey,
    };
  }
}
