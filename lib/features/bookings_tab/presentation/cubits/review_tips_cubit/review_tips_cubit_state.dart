import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/features/bookings_tab/data/models/review_request.dart';
import 'package:masaj/features/bookings_tab/data/repositories/review_repository.dart';

part 'review_tips_cubit.dart';

class ReviewTipsCubit extends Cubit<ReviewTipsCubitState> {
  final ReviewRepository _reviewRepository;
  final PaymentService _paymentService;

  ReviewTipsCubit(
    this._reviewRepository,
    this._paymentService,
  ) : super(ReviewTipsCubitState());

  // add review
  Future<void> addReview(ReviewRequest reviewRequest) async {
    emit(state.copyWith(status: ReviewTipsStatus.loading));
    try {
      
      await _reviewRepository.addReview(reviewRequest);
      emit(state.copyWith(status: ReviewTipsStatus.loaded, tipsSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          status: ReviewTipsStatus.error, errorMessage: e.toString()));
    }
  }
  Future<void> refresh() async {
    emit(state.copyWith(status: ReviewTipsStatus.initial));
  }
 
}
