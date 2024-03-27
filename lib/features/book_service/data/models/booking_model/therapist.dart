// import 'dart:convert';

// import 'package:collection/collection.dart';

// class Therapist {
//   int? id;
//   int? countryId;
//   String? fullNameEn;
//   String? fullNameAr;
//   String? titleEn;
//   String? titleAr;
//   String? aboutEn;
//   String? aboutAr;
//   String? profileImage;
//   int? commission;
//   bool? homePageFeatured;
//   int? homePageSortKey;
//   int? rank;
//   bool? isActive;

//   Therapist({
//     this.id,
//     this.countryId,
//     this.fullNameEn,
//     this.fullNameAr,
//     this.titleEn,
//     this.titleAr,
//     this.aboutEn,
//     this.aboutAr,
//     this.profileImage,
//     this.commission,
//     this.homePageFeatured,
//     this.homePageSortKey,
//     this.rank,
//     this.isActive,
//   });

//   @override
//   String toString() {
//     return 'Therapist(id: $id, countryId: $countryId, fullNameEn: $fullNameEn, fullNameAr: $fullNameAr, titleEn: $titleEn, titleAr: $titleAr, aboutEn: $aboutEn, aboutAr: $aboutAr, profileImage: $profileImage, commission: $commission, homePageFeatured: $homePageFeatured, homePageSortKey: $homePageSortKey, rank: $rank, isActive: $isActive)';
//   }

//   factory Therapist.fromMap(Map<String, dynamic> data) => Therapist(
//         id: data['id'] as int?,
//         countryId: data['countryId'] as int?,
//         fullNameEn: data['fullNameEn'] as String?,
//         fullNameAr: data['fullNameAr'] as String?,
//         titleEn: data['titleEn'] as String?,
//         titleAr: data['titleAr'] as String?,
//         aboutEn: data['aboutEn'] as String?,
//         aboutAr: data['aboutAr'] as String?,
//         profileImage: data['profileImage'] as String?,
//         commission: data['commission'] as int?,
//         homePageFeatured: data['homePageFeatured'] as bool?,
//         homePageSortKey: data['homePageSortKey'] as int?,
//         rank: data['rank'] as int?,
//         isActive: data['isActive'] as bool?,
//       );

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'countryId': countryId,
//         'fullNameEn': fullNameEn,
//         'fullNameAr': fullNameAr,
//         'titleEn': titleEn,
//         'titleAr': titleAr,
//         'aboutEn': aboutEn,
//         'aboutAr': aboutAr,
//         'profileImage': profileImage,
//         'commission': commission,
//         'homePageFeatured': homePageFeatured,
//         'homePageSortKey': homePageSortKey,
//         'rank': rank,
//         'isActive': isActive,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [Therapist].
//   factory Therapist.fromJson(String data) {
//     return Therapist.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [Therapist] to a JSON string.
//   String toJson() => json.encode(toMap());

//   Therapist copyWith({
//     int? id,
//     int? countryId,
//     String? fullNameEn,
//     String? fullNameAr,
//     String? titleEn,
//     String? titleAr,
//     String? aboutEn,
//     String? aboutAr,
//     String? profileImage,
//     int? commission,
//     bool? homePageFeatured,
//     int? homePageSortKey,
//     int? rank,
//     bool? isActive,
//   }) {
//     return Therapist(
//       id: id ?? this.id,
//       countryId: countryId ?? this.countryId,
//       fullNameEn: fullNameEn ?? this.fullNameEn,
//       fullNameAr: fullNameAr ?? this.fullNameAr,
//       titleEn: titleEn ?? this.titleEn,
//       titleAr: titleAr ?? this.titleAr,
//       aboutEn: aboutEn ?? this.aboutEn,
//       aboutAr: aboutAr ?? this.aboutAr,
//       profileImage: profileImage ?? this.profileImage,
//       commission: commission ?? this.commission,
//       homePageFeatured: homePageFeatured ?? this.homePageFeatured,
//       homePageSortKey: homePageSortKey ?? this.homePageSortKey,
//       rank: rank ?? this.rank,
//       isActive: isActive ?? this.isActive,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! Therapist) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       countryId.hashCode ^
//       fullNameEn.hashCode ^
//       fullNameAr.hashCode ^
//       titleEn.hashCode ^
//       titleAr.hashCode ^
//       aboutEn.hashCode ^
//       aboutAr.hashCode ^
//       profileImage.hashCode ^
//       commission.hashCode ^
//       homePageFeatured.hashCode ^
//       homePageSortKey.hashCode ^
//       rank.hashCode ^
//       isActive.hashCode;
// }
