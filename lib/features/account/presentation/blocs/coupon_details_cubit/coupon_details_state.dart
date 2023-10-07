part of 'coupon_details_cubit.dart';

enum CouponDetailsStateStatus { initial, loading, loaded, showCode, error }

extension CouponDetailsStateX on CouponDetailsState {
  bool get isInitial => status == CouponDetailsStateStatus.initial;
  bool get isLoading => status == CouponDetailsStateStatus.loading;
  bool get isLoaded => status == CouponDetailsStateStatus.loaded;
  bool get isShowCode => status == CouponDetailsStateStatus.showCode;
  bool get isError => status == CouponDetailsStateStatus.error;
}

@immutable
class CouponDetailsState {
  final CouponDetailsStateStatus status;
  final String? errorMessage;
  final CouponItem? couponDetails;
  final String? couponCode;

  const CouponDetailsState({
    required this.status,
    this.errorMessage,
    this.couponDetails,
    this.couponCode,
  });

  CouponDetailsState copyWith({
    CouponDetailsStateStatus? status,
    String? errorMessage,
    CouponItem? couponDetails,
    String? couponCode,
  }) {
    return CouponDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      couponDetails: couponDetails ?? this.couponDetails,
      couponCode: couponCode ?? this.couponCode,
    );
  }

  @override
  bool operator ==(covariant CouponDetailsState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.couponCode == couponCode &&
        other.couponDetails == couponDetails;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      couponDetails.hashCode ^
      couponCode.hashCode;
}
