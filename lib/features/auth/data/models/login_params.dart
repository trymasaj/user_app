import 'dart:convert';

class LoginParams {
  final String phoneNumber;
  final String countryCode;
  final String password;

  LoginParams({
    required this.phoneNumber,
    required this.countryCode,
    required this.password,
  });

  LoginParams copyWith({
    String? phoneNumber,
    String? countryCode,
    String? password,
  }) {
    return LoginParams(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      phoneNumber: map['phoneNumber'],
      countryCode: map['countryCode'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginParams.fromJson(String source) =>
      LoginParams.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginParams(phoneNumber: $phoneNumber, countryCode: $countryCode, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginParams &&
        other.phoneNumber == phoneNumber &&
        other.countryCode == countryCode &&
        other.password == password;
  }

  @override
  int get hashCode =>
      phoneNumber.hashCode ^ countryCode.hashCode ^ password.hashCode;
}
