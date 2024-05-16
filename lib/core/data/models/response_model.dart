import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ResponseModel {
  int? status;
  String? title;
  String? detail;
  Errors? errors;
  ResponseModel({
    this.status,
    this.title,
    this.detail,
    this.errors,
  });

  ResponseModel copyWith({
    ValueGetter<int?>? status,
    ValueGetter<String?>? title,
    ValueGetter<String?>? detail,
    ValueGetter<Errors?>? errors,
  }) {
    return ResponseModel(
      status: status != null ? status() : this.status,
      title: title != null ? title() : this.title,
      detail: detail != null ? detail() : this.detail,
      errors: errors != null ? errors() : this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'title': title,
      'detail': detail,
      'errors': errors?.toMap(),
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status']?.toInt(),
      title: map['title'],
      detail: map['detail'],
      errors: map['errors'] != null ? Errors.fromMap(map['errors']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseModel(status: $status, title: $title, detail: $detail, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.status == status &&
        other.title == title &&
        other.detail == detail &&
        other.errors == errors;
  }

  @override
  int get hashCode {
    return status.hashCode ^ title.hashCode ^ detail.hashCode ^ errors.hashCode;
  }
}

class Errors {
  List<String>? additionalProp1;
  List<String>? additionalProp2;
  List<String>? additionalProp3;
  Errors({
    this.additionalProp1,
    this.additionalProp2,
    this.additionalProp3,
  });

  Errors copyWith({
    ValueGetter<List<String>?>? additionalProp1,
    ValueGetter<List<String>?>? additionalProp2,
    ValueGetter<List<String>?>? additionalProp3,
  }) {
    return Errors(
      additionalProp1:
          additionalProp1 != null ? additionalProp1() : this.additionalProp1,
      additionalProp2:
          additionalProp2 != null ? additionalProp2() : this.additionalProp2,
      additionalProp3:
          additionalProp3 != null ? additionalProp3() : this.additionalProp3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'additionalProp1': additionalProp1,
      'additionalProp2': additionalProp2,
      'additionalProp3': additionalProp3,
    };
  }

  factory Errors.fromMap(Map<String, dynamic> map) {
    return Errors(
      additionalProp1: List<String>.from(map['additionalProp1']),
      additionalProp2: List<String>.from(map['additionalProp2']),
      additionalProp3: List<String>.from(map['additionalProp3']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Errors.fromJson(String source) => Errors.fromMap(json.decode(source));

  @override
  String toString() =>
      'Errors(additionalProp1: $additionalProp1, additionalProp2: $additionalProp2, additionalProp3: $additionalProp3)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Errors &&
        listEquals(other.additionalProp1, additionalProp1) &&
        listEquals(other.additionalProp2, additionalProp2) &&
        listEquals(other.additionalProp3, additionalProp3);
  }

  @override
  int get hashCode =>
      additionalProp1.hashCode ^
      additionalProp2.hashCode ^
      additionalProp3.hashCode;
}
