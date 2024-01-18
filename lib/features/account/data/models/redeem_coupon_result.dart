import 'dart:convert';

class RedeemCouponResult {
  final int currentPoints;
  final bool? success;

  RedeemCouponResult({
    required this.currentPoints,
    this.success,
  });

  RedeemCouponResult copyWith({
    int? currentPoints,
    bool? success,
  }) {
    return RedeemCouponResult(
      currentPoints: currentPoints ?? this.currentPoints,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentPoints': currentPoints,
      'success': success,
    };
  }

  factory RedeemCouponResult.fromMap(Map<String, dynamic> map) {
    return RedeemCouponResult(
      currentPoints: map['currentPoints']?.toInt() ?? 0,
      success: map['success'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RedeemCouponResult.fromJson(String source) =>
      RedeemCouponResult.fromMap(json.decode(source));

  @override
  String toString() =>
      'RedeemCouponResult(currentPoints: $currentPoints, success: $success)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RedeemCouponResult &&
        other.currentPoints == currentPoints &&
        other.success == success;
  }

  @override
  int get hashCode => currentPoints.hashCode ^ success.hashCode;
}
