import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final int serviceId;
  final int serviceCategoryId;
  final int countryId;
  final String title;
  final String description;
  final bool isActive;
  final bool allowFocusAreas;
  final int sortKey;
  final double startingPrice;
  final List<ServiceBenefitModel>? serviceBenefits;
  final List<ServiceDurationModel>? serviceDurations;
  final List<ServiceMediaModel>? serviceMedia;
  final List<ServiceAddonModel>? serviceAddons;

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
        sortKey,
        startingPrice,
        serviceBenefits,
        serviceDurations,
        serviceMedia,
        serviceAddons,
      ];

  factory ServiceModel.fromMap(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['serviceId'],
      serviceCategoryId: json['serviceCategoryId'],
      countryId: json['countryId'],
      title: json['title'],
      description: json['description'],
      isActive: json['isActive'],
      allowFocusAreas: json['allowFocusAreas'],
      sortKey: json['sortKey'],
      startingPrice: json['startingPrice'],
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceCategoryId': serviceCategoryId,
      'countryId': countryId,
      'title': title,
      'description': description,
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
      startingPrice: startingPrice ?? this.startingPrice,
      serviceBenefits: serviceBenefits ?? this.serviceBenefits,
      serviceDurations: serviceDurations ?? this.serviceDurations,
      serviceMedia: serviceMedia ?? this.serviceMedia,
      serviceAddons: serviceAddons ?? this.serviceAddons,
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

  const ServiceDurationModel({
    required this.serviceDurationId,
    required this.duration,
    required this.isPromoted,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceDurationId': serviceDurationId,
      'duration': duration,
      'isPromoted': isPromoted,
      'price': price,
    };
  }

  factory ServiceDurationModel.fromMap(Map<String, dynamic> json) {
    return ServiceDurationModel(
      serviceDurationId: json['serviceDurationId'],
      duration: json['duration'],
      isPromoted: json['isPromoted'],
      price: json['price'],
    );
  }
}

class ServiceMediaModel {
  final int mediaId;
  final bool isMain;
  final String mediaUrl;
  final int mediaType;
  final int mediaPosition;

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
      price: json['price'],
      duration: json['duration'],
    );
  }
}
