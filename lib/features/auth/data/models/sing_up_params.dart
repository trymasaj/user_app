// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/enums/gender.dart';

class SignUpParams {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? phone;
  final String? countryCode;
  final int? countryId;
  final DateTime? birthDate;
  final Gender? gender;

  SignUpParams({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.gender,
    this.countryCode,
    this.countryId,
    this.birthDate,
    this.phone,
    this.confirmPassword,
  });

  SignUpParams copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? countryCode,
    int? countryId,
    DateTime? birthDate,
    Gender? gender,
  }) =>
      SignUpParams(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        phone: phone ?? this.phone,
        countryCode: countryCode ?? this.countryCode,
        countryId: countryId ?? this.countryId,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
      );

  // toMap
  Map<String, dynamic> toMap() => <String, dynamic>{
        "fullName": fullName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "countryCode": countryCode,
        "countryId": countryId,
        "gender": gender?.index,
        if (birthDate != null) "birthDate": birthDate!.toIso8601String()
      };

  // fromMap
  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    return SignUpParams(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      confirmPassword: map['confirmPassword'],
      phone: map['phone'],
      countryCode: map['countryCode'],
      countryId: map['countryId'],
      birthDate:
          map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      gender: map['gender'] != null ? Gender.values[map['gender']] : null,
    );
  }

  // toJson
  String toJson() => json.encode(toMap());

  // fromJson
  factory SignUpParams.fromJson(String source) => SignUpParams.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpParams &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fullName == other.fullName &&
          email == other.email &&
          password == other.password &&
          confirmPassword == other.confirmPassword &&
          phone == other.phone &&
          countryCode == other.countryCode &&
          countryId == other.countryId &&
          birthDate == other.birthDate &&
          gender == other.gender;

  @override
  int get hashCode =>
      id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode ^
      phone.hashCode ^
      countryCode.hashCode ^
      countryId.hashCode ^
      birthDate.hashCode ^
      gender.hashCode;
}
