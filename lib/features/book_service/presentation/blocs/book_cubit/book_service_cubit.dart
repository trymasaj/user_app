import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/enums/taps_enum.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

import '../../../data/models/booking_model/booking_model.dart';

part 'book_service_state.dart';

class BookingCubit extends BaseCubit<BookingState> {
  BookingCubit(BookingRepository bookingRepository)
      : _bookingRepository = bookingRepository,
        super(const BookingState(status: BookServiceStatus.initial));

  final BookingRepository _bookingRepository;

  Future<void> getLatestBookingId() async {
    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      await _bookingRepository.getBookingLatestId();
      emit(state.copyWith(status: BookServiceStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBookingService(ServiceBookModel? serviceBookModel) async {
    if (serviceBookModel == null) return;
    try {
      emit(state.copyWith(status: BookServiceStatus.loading));

      await _bookingRepository.addBookingService(serviceBookModel);
      emit(state.copyWith(status: BookServiceStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBookingMembers(List<int>? members) async {
    if (members == null) return;

    try {
      emit(state.copyWith(status: BookServiceStatus.loading));
      await _bookingRepository.addBookingMembers(members);
      emit(state.copyWith(status: BookServiceStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBookingAddress(int? addressId) async {
    if (addressId == null) return;

    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      await _bookingRepository.addBookingAddress(addressId);
      emit(state.copyWith(status: BookServiceStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBookingTherapist(
      {int? therapistId, DateTime? availableTime}) async {
    if (therapistId == null || availableTime == null) return;

    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      await _bookingRepository.addBookingTherapist(
        therapistId: therapistId,
        availableTime: availableTime,
      );
      emit(state.copyWith(status: BookServiceStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addBookingVoucher(String? voucherId) async {
    if (voucherId == null) return;

    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      final bookingModel =
          await _bookingRepository.addBookingVoucher(voucherId);
      emit(state.copyWith(
          status: BookServiceStatus.couponApplied, bookingModel: bookingModel));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deleteBookingVoucher(String? voucherId) async {
    if (voucherId == null) return;

    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      final bookingModel =
          await _bookingRepository.deleteBookingVoucher(voucherId);
      emit(state.copyWith(
          status: BookServiceStatus.couponRemoved, bookingModel: bookingModel));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getBookingDetails({int? oldBookingId}) async {
    emit(state.copyWith(status: BookServiceStatus.loading));
    try {
      final bookingId =
          oldBookingId ?? await _bookingRepository.getBookingLatestId();
      final booking = await _bookingRepository.getBookingDetails(bookingId);
      emit(state.copyWith(
          status: BookServiceStatus.loaded, bookingModel: booking));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BookServiceStatus.error, errorMessage: e.toString()));
    }
  }

  void setSelectedTherapist(Therapist? therapist) {
    emit(state.copyWith(selectedTherapist: therapist));
  }

  void clearTherapist() {
    emit(state.copyWith(clearTherapist: true));
  }
}
