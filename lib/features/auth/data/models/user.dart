// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:masaj/core/enums/age_group.dart';

import '../../../../core/enums/gender.dart';

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? accessToken;
  final String? refreshToken;
  final String? idToken;
  final int? provider;
  final Gender? gender;
  final AgeGroup? ageGroup;
  final String? googleAccessToken;
  final int? deviceType;
  final String? mobileAppId;
  final bool? emailVerified;
  final bool? interestsSelected;
  final int? points;
  final bool? notificationEnabled;
  final String? mobile;
  final bool? completeRegistration;

  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.accessToken,
    this.refreshToken,
    this.idToken,
    this.provider,
    this.gender,
    this.ageGroup,
    this.googleAccessToken,
    this.deviceType,
    this.mobileAppId,
    this.emailVerified,
    this.interestsSelected,
    this.points,
    this.notificationEnabled,
    this.mobile,
    this.completeRegistration,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? accessToken,
    String? refreshToken,
    String? ticketMXAccessToken,
    String? idToken,
    int? provider,
    Gender? gender,
    AgeGroup? ageGroup,
    String? googleAccessToken,
    int? deviceType,
    String? mobileAppId,
    bool? completeRegistration,
    bool? emailVerified,
    bool? interestsSelected,
    int? points,
    bool? notificationEnabled,
    String? mobile,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      idToken: idToken ?? this.idToken,
      provider: provider ?? this.provider,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      googleAccessToken: googleAccessToken ?? this.googleAccessToken,
      deviceType: deviceType ?? this.deviceType,
      mobileAppId: mobileAppId ?? this.mobileAppId,
      emailVerified: emailVerified ?? this.emailVerified,
      interestsSelected: interestsSelected ?? this.interestsSelected,
      points: points ?? this.points,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      mobile: mobile ?? this.mobile,
      completeRegistration: completeRegistration ?? this.completeRegistration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'idToken': idToken,
      'provider': provider,
      'gender': gender?.id,
      'ageGroup': ageGroup?.index,
      'googleAccessToken': googleAccessToken,
      'deviceType': deviceType,
      'mobileAppId': mobileAppId,
      'emailVerified': emailVerified,
      'interestsSelected': interestsSelected,
      'points': points,
      'notificationEnabled': notificationEnabled,
      'mobile': mobile,
      'completeRegistration': completeRegistration,
    }..removeWhere((_, v) => v == null);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      idToken: map['idToken'],
      provider: map['provider']?.toInt(),
      gender: Gender.values.firstWhereOrNull((e) => e.id == map['gender']),
      ageGroup:
          AgeGroup.values.firstWhereOrNull((e) => e.index == map['ageGroup']),
      googleAccessToken: map['googleAccessToken'],
      deviceType: map['deviceType']?.toInt(),
      mobileAppId: map['mobileAppId'],
      emailVerified: map['emailVerified'],
      interestsSelected: map['interestsSelected'],
      points: map['points']?.toInt(),
      notificationEnabled: map['notificationEnabled'],
      mobile: map['mobile'],
      completeRegistration: map['completeRegistration'],
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
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.idToken == idToken &&
        other.provider == provider &&
        other.gender == gender &&
        other.ageGroup == ageGroup &&
        other.googleAccessToken == googleAccessToken &&
        other.deviceType == deviceType &&
        other.mobileAppId == mobileAppId &&
        other.emailVerified == emailVerified &&
        other.interestsSelected == interestsSelected &&
        other.points == points &&
        other.notificationEnabled == notificationEnabled &&
        other.mobile == mobile &&
        other.completeRegistration == completeRegistration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        idToken.hashCode ^
        provider.hashCode ^
        gender.hashCode ^
        ageGroup.hashCode ^
        googleAccessToken.hashCode ^
        deviceType.hashCode ^
        mobileAppId.hashCode ^
        emailVerified.hashCode ^
        interestsSelected.hashCode ^
        points.hashCode ^
        notificationEnabled.hashCode ^
        mobile.hashCode;
  }
}
