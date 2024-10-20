import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';

import 'package:masaj/features/bookings_tab/data/repositories/bookings_tab_repository.dart';

part 'bookings_tab_state.dart';

class BookingsTabCubit extends BaseCubit<BookingsTabState> {
  BookingsTabCubit({
    required BookingRepository bookingsTabRepository,
  })  : _bookingsTabRepository = bookingsTabRepository,
        super(const BookingsTabState(status: BookingsTabStateStatus.initial));

  final BookingRepository _bookingsTabRepository;
  Future<void> loadServices({
    bool refresh = false,
  }) async {
    if (state.isLoading) return;
    if (refresh) {
      emit(state.copyWith(status: BookingsTabStateStatus.isRefreshing));
    } else {
      emit(state.copyWith(status: BookingsTabStateStatus.loading));
    }

    try {
      final sessionsResponse =
          await _bookingsTabRepository.getBookingList(BookingQueryModel(
        status: state.type,
        page: state.page,
        pageSize: state.pageSize,
      ));
      emit(state.copyWith(
        status: BookingsTabStateStatus.loaded,
        sessions: sessionsResponse.data,
        page: 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingsTabStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreServices() async {

    if (state.isLoadingMore) return;
    if (state.sessions.isEmpty) return;
    emit(state.copyWith(status: BookingsTabStateStatus.loadingMore));
    try {
      final sessionsResponse =
          await _bookingsTabRepository.getBookingList(BookingQueryModel(
        status: state.type,
        page: state.page! + 1,
        pageSize: state.pageSize,
      ));
      final newData = sessionsResponse?.data ?? [];
      emit(state.copyWith(
        status: BookingsTabStateStatus.loaded,
        sessions: [...state.sessions, ...newData],
        page: state.page! + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingsTabStateStatus.error,
        errorMessage: e.toString(),
      ));
    }

    // change type
  }

  void changeType(BookingQueryStatus type) {
    emit(state.copyWith(type: type, page: 1));
    loadServices();
  }
//
}
