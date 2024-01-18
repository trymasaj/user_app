// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:masaj/core/domain/enums/age_group.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/domain/enums/user_type.dart';

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  final String? token;
  final String? refreshToken;
  final String? idToken;
  final int? provider;
  final Gender? gender;
  final AgeGroup? ageGroup;
  final String? googleAccessToken;
  final int? deviceType;
  final String? mobileAppId;
  final bool? interestsSelected;
  final int? points;
  final bool? notificationEnabled;
  final String? mobile;
  final String? phone;
  final String? countryCode;
  final int? countryId;
  final bool? verified;
  final DateTime? birthDate;
  final String? profileImage;

  // userType
  final UserType? userType;

  //isProfileCompleted
  final bool? isProfileCompleted;

  //quizAnswered
  final bool? quizAnswered;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.password,
      this.token,
      this.refreshToken,
      this.idToken,
      this.provider,
      this.gender,
      this.ageGroup,
      this.googleAccessToken,
      this.deviceType,
      this.mobileAppId,
      this.interestsSelected,
      this.points,
      this.notificationEnabled,
      this.mobile,
      this.phone,
      this.countryCode,
      this.countryId,
      this.verified,
      this.birthDate,
      this.profileImage,
      this.userType,
      this.isProfileCompleted,
      this.quizAnswered,
      this.confirmPassword});

  User copyWith(
      {String? id,
      String? fullName,
      String? email,
      String? password,
      String? token,
      String? refreshToken,
      String? ticketMXAccessToken,
      String? idToken,
      int? provider,
      Gender? gender,
      AgeGroup? ageGroup,
      String? googleAccessToken,
      int? deviceType,
      String? mobileAppId,
      bool? emailVerified,
      bool? interestsSelected,
      int? points,
      bool? notificationEnabled,
      String? mobile,
      String? phone,
      String? countryCode,
      int? countryId,
      bool? verified,
      DateTime? birthDate,
      String? profileImage,
      UserType? userType,
      bool? isProfileCompleted,
      bool? quizAnswered,
      String? confirmPassword}) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      idToken: idToken ?? this.idToken,
      provider: provider ?? this.provider,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      googleAccessToken: googleAccessToken ?? this.googleAccessToken,
      deviceType: deviceType ?? this.deviceType,
      mobileAppId: mobileAppId ?? this.mobileAppId,
      interestsSelected: interestsSelected ?? this.interestsSelected,
      points: points ?? this.points,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      mobile: mobile ?? this.mobile,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      countryId: countryId ?? this.countryId,
      verified: verified ?? this.verified,
      birthDate: birthDate ?? this.birthDate,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'accessToken': token,
      'refreshToken': refreshToken,
      'phone': phone,
      'idToken': idToken,
      'provider': provider,
      'gender': gender?.id,
      'ageGroup': ageGroup?.index,
      'googleAccessToken': googleAccessToken,
      'deviceType': deviceType,
      'mobileAppId': mobileAppId,
      'interestsSelected': interestsSelected,
      'points': points,
      'notificationEnabled': notificationEnabled,
      'mobile': mobile,
      'countryCode': countryCode,
      'countryId': countryId,
      'confirmPassword': confirmPassword,
      'verified': verified,
      'birthDate': birthDate?.toIso8601String(),
      'profileImage': profileImage,
      'userType': userType?.index,
      'isProfileCompleted': isProfileCompleted,
      'quizAnswered': quizAnswered,
      'token': token,
    }..removeWhere((_, v) => v == null);
  }

  Map<String, dynamic> toSocialMediaMap() {
    return {
      'token': idToken,
      'countryId': countryId,
      'provider': provider,
      'deviceType': deviceType,
      'mobileAppId': mobileAppId,
    }..removeWhere((_, v) => v == null);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
      refreshToken: map['refreshToken'],
      idToken: map['idToken'],
      provider: map['provider']?.toInt(),
      gender: Gender.values.firstWhereOrNull((e) => e.id == map['gender']),
      ageGroup:
          AgeGroup.values.firstWhereOrNull((e) => e.index == map['ageGroup']),
      googleAccessToken: map['googleAccessToken'],
      deviceType: map['deviceType']?.toInt(),
      mobileAppId: map['mobileAppId'],
      interestsSelected: map['interestsSelected'],
      points: map['points']?.toInt(),
      notificationEnabled: map['notificationEnabled'],
      mobile: map['mobile'],
      phone: map['phone'],
      countryCode: map['countryCode'],
      countryId: map['countryId']?.toInt(),
      verified: map['verified'],
      birthDate:
          map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      profileImage: map['profileImage'],
      userType: UserType.values
          .firstWhereOrNull((e) => e.index == map['userType']?.toInt()),
      isProfileCompleted: map['isProfileCompleted'],
      quizAnswered: map['quizAnswered'],
      confirmPassword: map['confirmPassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password &&
        other.token == token &&
        other.refreshToken == refreshToken &&
        other.idToken == idToken &&
        other.provider == provider &&
        other.gender == gender &&
        other.ageGroup == ageGroup &&
        other.googleAccessToken == googleAccessToken &&
        other.deviceType == deviceType &&
        other.mobileAppId == mobileAppId &&
        other.interestsSelected == interestsSelected &&
        other.points == points &&
        other.notificationEnabled == notificationEnabled &&
        other.mobile == mobile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        refreshToken.hashCode ^
        idToken.hashCode ^
        provider.hashCode ^
        gender.hashCode ^
        ageGroup.hashCode ^
        googleAccessToken.hashCode ^
        deviceType.hashCode ^
        mobileAppId.hashCode ^
        interestsSelected.hashCode ^
        points.hashCode ^
        notificationEnabled.hashCode ^
        mobile.hashCode;
  }
}
