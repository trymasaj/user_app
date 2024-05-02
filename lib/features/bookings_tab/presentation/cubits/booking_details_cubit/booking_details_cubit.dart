import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';

part 'booking_details_state.dart';

class BookingDetailsCubit extends BaseCubit<BookingDetailsState> {
  final BookingRepository _bookingRepository;

  BookingDetailsCubit(this._bookingRepository)
      : super(BookingDetailsState.initial());

  Future<void> getBookingDetails(int bookingId) async {
    emit(state.copyWith(status: BookingDetailsStatus.loading));
    try {
      final booking = await _bookingRepository.getBookingDetails(bookingId);
      emit(state.copyWith(
          status: BookingDetailsStatus.success, booking: booking));
    } catch (e) {
      emit(state.copyWith(
          status: BookingDetailsStatus.error, error: e.toString()));
    }
  }
}
