import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ServiceModel extends Equatable {
  final int serviceId;
  final int serviceCategoryId;
  final int countryId;
  final String? title;
  final String? description;
  final bool? isActive;
  final bool allowFocusAreas;
  final double? discountedPrice;
  final bool hasDiscount;
  final int sortKey;
  final double startingPrice;
  final List<ServiceBenefitModel>? serviceBenefits;
  final List<ServiceDurationModel>? serviceDurations;
  final List<ServiceMediaModel>? serviceMedia;
  final List<ServiceAddonModel>? serviceAddons;
  final String? mainImage;
  List<String> get images => [
        if (mainImage != null) mainImage!,
        if (serviceMedia != null)
          ...serviceMedia!
              .where((element) => element.isImage)
              .map((e) => e.mediaUrl)
      ];
  // videos
  List<String> get videos => [
        if (serviceMedia != null)
          ...serviceMedia!
              .where((element) => element.isVideo)
              .map((e) => e.mediaUrl)
      ];
  const ServiceModel({
    required this.serviceId,
    required this.serviceCategoryId,
    required this.countryId,
    required this.title,
    required this.description,
    required this.isActive,
    required this.allowFocusAreas,
    required this.sortKey,
    required this.startingPrice,
    this.serviceBenefits,
    this.serviceDurations,
    this.serviceMedia,
    this.serviceAddons,
    this.mainImage,
    this.discountedPrice,
    this.hasDiscount = false,
  });

  @override
  List<Object?> get props => [
        serviceId,
        serviceCategoryId,
        countryId,
        title,
        description,
        isActive,
        allowFocusAreas,
        mainImage,
        sortKey,
        startingPrice,
        serviceBenefits,
        serviceDurations,
        serviceMedia,
        serviceAddons,
        discountedPrice,
        hasDiscount,
      ];

  factory ServiceModel.fromMap(Map<String, dynamic> json) {
    try {
      ServiceModel(
        mainImage: json['mainImage'],
        serviceId: json['serviceId'],
        serviceCategoryId: json['serviceCategoryId'],
        countryId: json['countryId'],
        title: json['title'],
        description: json['description'],
        isActive: json['isActive'],
        allowFocusAreas: json['allowFocusAreas'] ?? false,
        sortKey: json['sortKey'],
        startingPrice: (json['startingPrice'] as num).toDouble(),
        serviceBenefits: json['serviceBenefits'] == null
            ? null
            : List<ServiceBenefitModel>.from(json['serviceBenefits']
                .map((x) => ServiceBenefitModel.fromMap(x))),
        serviceDurations: json['serviceDurations'] == null
            ? null
            : List<ServiceDurationModel>.from(json['serviceDurations']
                .map((x) => ServiceDurationModel.fromMap(x))),
        serviceMedia: json['serviceMedia'] == null
            ? null
            : List<ServiceMediaModel>.from(
                json['serviceMedia'].map((x) => ServiceMediaModel.fromMap(x))),
        serviceAddons: json['serviceAddons'] == null
            ? null
            : List<ServiceAddonModel>.from(
                json['serviceAddons'].map((x) => ServiceAddonModel.fromMap(x))),
        hasDiscount: json['hasDiscount'] ?? false,
        discountedPrice: (json['discountedPrice'] as num).toDouble(),
      );
    } catch (e, s) {

    }
    return ServiceModel(
      mainImage: json['mainImage'],
      serviceId: json['serviceId'],
      serviceCategoryId: json['serviceCategoryId'],
      countryId: json['countryId'],
      title: json['title'],
      description: json['description'],
      isActive: json['isActive'],
      allowFocusAreas: json['allowFocusAreas'] ?? false,
      sortKey: json['sortKey'],
      startingPrice: (json['startingPrice'] as num).toDouble(),
      serviceBenefits: json['serviceBenefits'] == null
          ? null
          : List<ServiceBenefitModel>.from(json['serviceBenefits']
              .map((x) => ServiceBenefitModel.fromMap(x))),
      serviceDurations: json['serviceDurations'] == null
          ? null
          : List<ServiceDurationModel>.from(json['serviceDurations']
              .map((x) => ServiceDurationModel.fromMap(x))),
      serviceMedia: json['serviceMedia'] == null
          ? null
          : List<ServiceMediaModel>.from(
              json['serviceMedia'].map((x) => ServiceMediaModel.fromMap(x))),
      serviceAddons: json['serviceAddons'] == null
          ? null
          : List<ServiceAddonModel>.from(
              json['serviceAddons'].map((x) => ServiceAddonModel.fromMap(x))),
      hasDiscount: json['hasDiscount'] ?? false,
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceCategoryId': serviceCategoryId,
      'countryId': countryId,
      'title': title,
      'description': description,
      'mainImage': mainImage,
      'isActive': isActive,
      'allowFocusAreas': allowFocusAreas,
      'sortKey': sortKey,
      'startingPrice': startingPrice,
      'serviceBenefits': serviceBenefits == null
          ? null
          : List<dynamic>.from(serviceBenefits!.map((x) => x.toMap())),
      'serviceDurations': serviceDurations == null
          ? null
          : List<dynamic>.from(serviceDurations!.map((x) => x.toMap())),
      'serviceMedia': serviceMedia == null
          ? null
          : List<dynamic>.from(serviceMedia!.map((x) => x.toMap())),
      'serviceAddons': serviceAddons == null
          ? null
          : List<dynamic>.from(serviceAddons!.map((x) => x.toMap())),
      "discountedPrice": discountedPrice,
      "hasDiscount": hasDiscount,
    };
  }

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  ServiceModel copyWith({
    int? serviceId,
    int? serviceCategoryId,
    int? countryId,
    String? title,
    String? description,
    bool? isActive,
    bool? allowFocusAreas,
    int? sortKey,
    double? startingPrice,
    List<ServiceBenefitModel>? serviceBenefits,
    List<ServiceDurationModel>? serviceDurations,
    List<ServiceMediaModel>? serviceMedia,
    List<ServiceAddonModel>? serviceAddons,
    String? mainImage,
    double? discountedPrice,
    bool? hasDiscount,
  }) {
    return ServiceModel(
      serviceId: serviceId ?? this.serviceId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      countryId: countryId ?? this.countryId,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      allowFocusAreas: allowFocusAreas ?? this.allowFocusAreas,
      sortKey: sortKey ?? this.sortKey,
      mainImage: mainImage ?? this.mainImage,
      startingPrice: startingPrice ?? this.startingPrice,
      serviceBenefits: serviceBenefits ?? this.serviceBenefits,
      serviceDurations: serviceDurations ?? this.serviceDurations,
      serviceMedia: serviceMedia ?? this.serviceMedia,
      serviceAddons: serviceAddons ?? this.serviceAddons,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      hasDiscount: hasDiscount ?? this.hasDiscount,
    );
  }
}

class ServiceBenefitModel {
  final int benefitId;
  final String benefit;

  const ServiceBenefitModel({
    required this.benefitId,
    required this.benefit,
  });

  Map<String, dynamic> toMap() {
    return {
      'benefitId': benefitId,
      'benefit': benefit,
    };
  }

  factory ServiceBenefitModel.fromMap(Map<String, dynamic> json) {
    return ServiceBenefitModel(
      benefitId: json['benefitId'],
      benefit: json['benefit'],
    );
  }
}

class ServiceDurationModel {
  final int serviceDurationId;
  final String duration;
  final bool isPromoted;
  final double price;
  final bool hasDiscount;
  final double? discountedPrice;

  //  duration like 00:30:00
  String get durationInMinutes => duration.split(':').length > 2
      ? (int.parse(duration.split(':')[0]) * 60 +
              int.parse(duration.split(':')[1]))
          .toString()
      : duration.split(':')[1];
  String get durationInHours => duration.split(':').length > 2
      ? (int.parse(duration.split(':')[0]) * 60 +
              int.parse(duration.split(':')[1]))
          .toString()
      : duration.split(':')[0];
  int get durationInMinutesInt => int.parse(durationInMinutes);

  String get formattedString {
    // if duration hourse is 0 return minutes if not return hours and minutes if minutes is not 0 if not return hours
    final hourse = int.parse(duration.split(':')[0]);
    final minutes = int.parse(duration.split(':')[1]);
    if (hourse == 0) {
      return '$minutes';
    }
    if (minutes == 0) {
      return '$hourse';
    }
    return '$hourse:$minutes';
  }

  String get unit {
    final hourse = int.parse(duration.split(':')[0]);
    final minutes = int.parse(duration.split(':')[1]);
    if (hourse == 0) {
      return 'Minutes';
    }
    if (minutes == 0) {
      return 'Hours';
    }
    return 'Hours';
  }

  const ServiceDurationModel({
    required this.serviceDurationId,
    required this.duration,
    required this.isPromoted,
    required this.price,
    this.hasDiscount = false,
    this.discountedPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceDurationId': serviceDurationId,
      'duration': duration,
      'isPromoted': isPromoted,
      'price': price,
      "discountedPrice": discountedPrice,
      "hasDiscount": hasDiscount,
    };
  }

  factory ServiceDurationModel.fromMap(Map<String, dynamic> json) {
    return ServiceDurationModel(
      serviceDurationId: json['serviceDurationId'],
      duration: json['duration'],
      isPromoted: json['isPromoted'],
      price: (json['price'] as num).toDouble(),
      hasDiscount: json['hasDiscount'] ?? false,
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
    );
  }
}

class ServiceMediaModel {
  final int mediaId;
  final bool isMain;
  final String mediaUrl;
  final int mediaType;
  final int mediaPosition;
  bool get isImage => ['jpg', 'jpeg', 'png', 'gif']
      .contains(mediaUrl.split('.').last.toLowerCase());
  bool get isVideo => ['mp4', 'mov', 'avi', 'flv', 'wmv']
      .contains(mediaUrl.split('.').last.toLowerCase());

  const ServiceMediaModel({
    required this.mediaId,
    required this.isMain,
    required this.mediaUrl,
    required this.mediaType,
    required this.mediaPosition,
  });

  Map<String, dynamic> toMap() {
    return {
      'mediaId': mediaId,
      'isMain': isMain,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'mediaPosition': mediaPosition,
    };
  }

  factory ServiceMediaModel.fromMap(Map<String, dynamic> json) {
    return ServiceMediaModel(
      mediaId: json['mediaId'],
      isMain: json['isMain'],
      mediaUrl: json['mediaUrl'],
      mediaType: json['mediaType'],
      mediaPosition: json['mediaPosition'],
    );
  }
}

class ServiceAddonModel {
  final int addonId;
  final String title;
  final String description;
  final double price;
  final String duration;

  const ServiceAddonModel({
    required this.addonId,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
  });
  int get durationInMinutesInt => int.parse(durationInMinutes);

  Map<String, dynamic> toMap() {
    return {
      'addonId': addonId,
      'title': title,
      'description': description,
      'price': price,
      'duration': duration,
    };
  }

  factory ServiceAddonModel.fromMap(Map<String, dynamic> json) {
    return ServiceAddonModel(
      addonId: json['addonId'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      duration: json['duration'],
    );
  }

  //  duration like 00:30:00
  String get durationInMinutes => duration.split(':').length > 2
      ? (int.parse(duration.split(':')[0]) * 60 +
              int.parse(duration.split(':')[1]))
          .toString()
      : duration.split(':')[1];
  String get durationInHours => duration.split(':').length > 2
      ? (int.parse(duration.split(':')[0]) * 60 +
              int.parse(duration.split(':')[1]))
          .toString()
      : duration.split(':')[0];

  String get formattedString {
    // if duration hourse is 0 return minutes if not return hours and minutes if minutes is not 0 if not return hours
    final hourse = int.parse(duration.split(':')[0]);
    final minutes = int.parse(duration.split(':')[1]);
    if (hourse == 0) {
      return '$minutes';
    }
    if (minutes == 0) {
      return '$hourse';
    }
    return '$hourse:$minutes';
  }

  String get unit {
    final hourse = int.parse(duration.split(':')[0]);
    final minutes = int.parse(duration.split(':')[1]);
    if (hourse == 0) {
      return 'Minutes';
    }
    if (minutes == 0) {
      return 'Hours';
    }
    return 'Hours';
  }
}

class ServicesResponse extends Equatable {
  static const empty = ServicesResponse(
    data: [],
    page: 0,
    pageSize: 0,
    totalCount: 0,
    totalPages: 0,
  );
  final List<ServiceModel>? data;
  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  const ServicesResponse({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  // copy with
  ServicesResponse copyWith({
    List<ServiceModel>? data,
    int? page,
    int? pageSize,
    int? totalCount,
    int? totalPages,
  }) {
    return ServicesResponse(
      data: data ?? this.data,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
    );
  }

// from map
  factory ServicesResponse.fromMap(Map<String, dynamic> json) {
    return ServicesResponse(
      data: List<ServiceModel>.from(
          json['data'].map((x) => ServiceModel.fromMap(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      'data':
          data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }

  factory ServicesResponse.fromJson(String source) =>
      ServicesResponse.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
  @override
  List<Object?> get props => [data, page, pageSize, totalCount, totalPages];
}

class ServiceBookModel {
  final int serviceId;
  final int? durationId;
  final List<int> addonIds;
  final List<int> focusAreas;
  ServiceBookModel({
    required this.serviceId,
    required this.durationId,
    required this.addonIds,
    required this.focusAreas,
  });

  ServiceBookModel copyWith({
    int? serviceId,
    int? durationId,
    List<int>? addonIds,
    List<int>? focusAreas,
  }) {
    return ServiceBookModel(
      serviceId: serviceId ?? this.serviceId,
      durationId: durationId ?? this.durationId,
      addonIds: addonIds ?? this.addonIds,
      focusAreas: focusAreas ?? this.focusAreas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      if (durationId != null) 'durationId': durationId,
      'addonIds': addonIds,
      'focusAreas': focusAreas,
    };
  }

  factory ServiceBookModel.fromMap(Map<String, dynamic> map) {
    return ServiceBookModel(
      serviceId: map['serviceId']?.toInt() ?? 0,
      durationId: map['durationId']?.toInt() ?? 0,
      addonIds: List<int>.from(map['addonIds']),
      focusAreas: List<int>.from(map['focusAreas']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceBookModel.fromJson(String source) =>
      ServiceBookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceBookModel(serviceId: $serviceId, durationId: $durationId, addonIds: $addonIds, focusAreas: $focusAreas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceBookModel &&
        other.serviceId == serviceId &&
        other.durationId == durationId &&
        listEquals(other.addonIds, addonIds) &&
        listEquals(other.focusAreas, focusAreas);
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        durationId.hashCode ^
        addonIds.hashCode ^
        focusAreas.hashCode;
  }
}
