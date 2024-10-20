import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/features/bookings_tab/data/models/review_request.dart';
import 'package:masaj/features/bookings_tab/data/repositories/review_repository.dart';
import 'package:masaj/main.dart';
part 'review_tips_cubit_state.dart';

class ReviewTipsCubit extends Cubit<ReviewTipsCubitState> {
  final ReviewRepository _reviewRepository;
  final PaymentService _paymentService;

  ReviewTipsCubit(
    this._reviewRepository,
    this._paymentService,
  ) : super(ReviewTipsCubitState());

  // add review
  Future<void> addReview(
      {required ReviewRequest reviewRequest,
      required int paymentMethodId,
      bool walletPayment = false,
      double? tipAmount,
      String? applePayToken}) async {
    emit(state.copyWith(status: ReviewTipsStatus.loading));
    try {
      if (tipAmount != null)
        await _paymentService.buy(PaymentParam(
          urlPath: '${ApiEndPoint.BOOKING}/${reviewRequest.bookingId}/tip',
          params: {
            'paymentMethod': paymentMethodId,
            if (applePayToken != null) 'applePayToken': applePayToken,
            'walletPayment': walletPayment,
            'amount': tipAmount ?? 0
          },
          paymentMethodId: paymentMethodId,
          onSuccess: () {
            emit(state.copyWith(status: ReviewTipsStatus.loaded));
            navigatorKey.currentState!.pop();
          },
          onFailure: () {
            emit(state.copyWith(
                status: ReviewTipsStatus.error,
                errorMessage: 'Payment failed'));
          },
        ));
      await _reviewRepository.addReview(reviewRequest);

      emit(state.copyWith(status: ReviewTipsStatus.loaded, tipsSuccess: true));
    } catch (e, s) {
      DI.find<AbsLogger>().error('[$runtimeType].addReview()' ,e);
      emit(state.copyWith(
          status: ReviewTipsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(status: ReviewTipsStatus.initial));
  }
}
