// {
//   "rating": 0,
//   "customerOpinion": "string",
//   "improveServicesHint": "string"
// }

import 'dart:convert';

class ReviewRequest {
  final int bookingId;
  final int? rating;
  final String? customerOpinion;
  final String? improveServicesHint;

  ReviewRequest({
    this.rating,
    this.customerOpinion,
    this.improveServicesHint,
    required this.bookingId,
  });

  ReviewRequest copyWith({
    int? rating,
    String? customerOpinion,
    String? improveServicesHint,
    int? bookinId,
  }) {
    return ReviewRequest(
      rating: rating ?? this.rating,
      customerOpinion: customerOpinion ?? this.customerOpinion,
      improveServicesHint: improveServicesHint ?? this.improveServicesHint,
      bookingId: bookinId ?? this.bookingId,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'rating': rating?.toInt(),
      'customerOpinion': customerOpinion,
      'improveServicesHint': improveServicesHint,
    }..removeWhere((key, value) => value == null);
    return map;
  }

  factory ReviewRequest.fromMap(Map<String, dynamic> map) {
    return ReviewRequest(
      rating: map['rating']?.double() ?? 0,
      bookingId: map['bookinId']?.toInt() ?? 0,
      customerOpinion: map['customerOpinion'] ?? '',
      improveServicesHint: map['improveServicesHint'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewRequest.fromJson(String source) =>
      ReviewRequest.fromMap(json.decode(source));
}
