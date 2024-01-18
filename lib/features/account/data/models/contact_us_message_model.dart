import 'dart:convert';

class ContactUsMessage {
  final String name;
  final String email;
  final String message;

  ContactUsMessage({
    required this.name,
    required this.email,
    required this.message,
  });

  ContactUsMessage copyWith({
    String? name,
    String? email,
    String? country,
    String? message,
    String? developerId,
    String? propertyId,
  }) {
    return ContactUsMessage(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
    }..removeWhere((_, v) => v == null);
  }

  factory ContactUsMessage.fromMap(Map<String, dynamic> map) {
    return ContactUsMessage(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsMessage.fromJson(String source) =>
      ContactUsMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactUsMessage(name: $name, email: $email, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactUsMessage &&
        other.name == name &&
        other.email == email &&
        other.message == message;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ message.hashCode;
  }
}
