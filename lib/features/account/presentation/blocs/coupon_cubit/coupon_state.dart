part of 'coupon_cubit.dart';

enum CouponStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  redeemSuccess,
  error,
}

extension CouponStateX on CouponState {
  bool get isInitial => status == CouponStateStatus.initial;
  bool get isLoading => status == CouponStateStatus.loading;
  bool get isLoaded => status == CouponStateStatus.loaded;
  bool get isRedeemSuccess => status == CouponStateStatus.redeemSuccess;
  bool get isLoadingMore => status == CouponStateStatus.loadingMore;
  bool get isError => status == CouponStateStatus.error;
}

@immutable
class CouponState {
  final CouponStateStatus status;
  final String? errorMessage;
  final Coupon? allCoupons;
  final Coupon? redeemedCoupons;
  final RedeemCouponResult? redeemCouponResult;

  const CouponState({
    this.status = CouponStateStatus.initial,
    this.errorMessage,
    this.allCoupons,
    this.redeemedCoupons,
    this.redeemCouponResult,
  });

  CouponState copyWith({
    CouponStateStatus? status,
    String? errorMessage,
    Coupon? allCoupons,
    Coupon? redeemedCoupons,
    RedeemCouponResult? redeemCouponResult,
  }) {
    return CouponState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      allCoupons: allCoupons ?? this.allCoupons,
      redeemedCoupons: redeemedCoupons ?? this.redeemedCoupons,
      redeemCouponResult: redeemCouponResult ?? this.redeemCouponResult,
    );
  }

  @override
  bool operator ==(covariant CouponState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.allCoupons == allCoupons &&
        other.redeemCouponResult == redeemCouponResult &&
        other.redeemedCoupons == redeemedCoupons;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      allCoupons.hashCode ^
      redeemedCoupons.hashCode ^
      redeemedCoupons.hashCode;
}
