// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeData {
  HomeData({
    this.date,
  });

  final String? date;

  HomeData copyWith({
    String? date,
  }) {
    return HomeData(
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
    };
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeData.fromJson(String source) =>
      HomeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HomeData(date: $date)';

  @override
  bool operator ==(covariant HomeData other) {
    if (identical(this, other)) return true;

    return other.date == date;
  }

  @override
  int get hashCode => date.hashCode;
}
