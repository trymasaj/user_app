//  [
//             new HomePageSection
//             {
//                 Id = 1,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-category",
//                 SortKey = 1,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 2,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-repeat",
//                 SortKey = 2,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 3,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-banners",
//                 SortKey = 3,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 4,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-offers",
//                 SortKey = 4,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 5,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-recommended",
//                 SortKey = 5,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 6,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-therapists",
//                 SortKey = 6,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 7,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-gifts",
//                 SortKey = 7,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             },
//             new HomePageSection
//             {
//                 Id = 8,
//                 CreatedAt = date,
//                 LastModifiedAt = date,
//                 SectionKey = "home-subscriptions",
//                 SortKey = 8,
//                 IsActive = true,
//                 IsForAndroid = true,
//                 IsForIos = true,
//                 CountryId = 1
//             }
//         ];

class HomeSectionModel {
  bool get isHomeCategory => sectionKey == 'home-category';
  bool get isHomeRepeat => sectionKey == 'home-repeat';
  bool get isHomeBanners => sectionKey == 'home-banners';
  bool get isHomeOffers => sectionKey == 'home-offers';
  bool get isHomeRecommended => sectionKey == 'home-recommended';
  bool get isHomeTherapists => sectionKey == 'home-therapists';
  bool get isHomeGifts => sectionKey == 'home-gifts';
  bool get isHomeSubscriptions => sectionKey == 'home-subscriptions';
  static const homeCategoryKey = 'home-category';
  static const homeRepeatKey = 'home-repeat';
  static const homeBanners = 'home-banners';
  static const homeOffetsKey = 'home-offers';
  static const homeRecommendedKey = 'home-recommended';
  static const homeTherapists = 'home-therapists';
  static const homeGifts = 'home-gifts';
  static const homeSubscriptions = 'home-subscriptions';
  HomeSectionModel({
    this.id,
    this.createdAt,
    this.lastModifiedAt,
    this.sectionKey,
    this.sortKey,
    this.isActive,
    this.isForAndroid,
    this.isForIos,
    this.countryId,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? lastModifiedAt;
  final String? sectionKey;
  final int? sortKey;
  final bool? isActive;
  final bool? isForAndroid;
  final bool? isForIos;
  final int? countryId;

  HomeSectionModel copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? sectionKey,
    int? sortKey,
    bool? isActive,
    bool? isForAndroid,
    bool? isForIos,
    int? countryId,
  }) {
    return HomeSectionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      sectionKey: sectionKey ?? this.sectionKey,
      sortKey: sortKey ?? this.sortKey,
      isActive: isActive ?? this.isActive,
      isForAndroid: isForAndroid ?? this.isForAndroid,
      isForIos: isForIos ?? this.isForIos,
      countryId: countryId ?? this.countryId,
    );
  }

  // from map
  factory HomeSectionModel.fromMap(Map<String, dynamic> map) {
    return HomeSectionModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastModifiedAt: map['lastModifiedAt'] != null
          ? DateTime.parse(map['lastModifiedAt'] as String)
          : null,
      sectionKey:
          map['sectionKey'] != null ? map['sectionKey'] as String : null,
      sortKey: map['sortKey'] != null ? map['sortKey'] as int : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      isForAndroid:
          map['isForAndroid'] != null ? map['isForAndroid'] as bool : null,
      isForIos: map['isForIos'] != null ? map['isForIos'] as bool : null,
      countryId: map['countryId'] != null ? map['countryId'] as int : null,
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'lastModifiedAt': lastModifiedAt?.toIso8601String(),
      'sectionKey': sectionKey,
      'sortKey': sortKey,
      'isActive': isActive,
      'isForAndroid': isForAndroid,
      'isForIos': isForIos,
      'countryId': countryId,
    };
  }

  @override
  String toString() {
    return 'HomeSectionModel(id: $id, createdAt: $createdAt, lastModifiedAt: $lastModifiedAt, sectionKey: $sectionKey, sortKey: $sortKey, isActive: $isActive, isForAndroid: $isForAndroid, isForIos: $isForIos, countryId: $countryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSectionModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.lastModifiedAt == lastModifiedAt &&
        other.sectionKey == sectionKey &&
        other.sortKey == sortKey &&
        other.isActive == isActive &&
        other.isForAndroid == isForAndroid &&
        other.isForIos == isForIos &&
        other.countryId == countryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        lastModifiedAt.hashCode ^
        sectionKey.hashCode ^
        sortKey.hashCode ^
        isActive.hashCode ^
        isForAndroid.hashCode ^
        isForIos.hashCode ^
        countryId.hashCode;
  }
}
