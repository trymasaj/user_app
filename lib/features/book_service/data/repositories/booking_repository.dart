import 'package:masaj/core/data/models/pagination_response.dart';
import 'package:masaj/features/book_service/data/datasources/booking_remote_data_source.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

abstract class BookingRepository {
  Future<int> getBookingLatestId();
  Future<void> addBookingService(ServiceBookModel serviceBookModel);
  Future<void> addBookingMembers(List<int> members);
  Future<void> addBookingAddress(int addressId);
  Future<void> addBookingTherapist(
      {required int therapistId, required DateTime availableTime});
  Future<BookingModel> addBookingVoucher(String voucherId);
  Future<BookingModel> deleteBookingVoucher(String voucherId);
  Future<void> confirmBooking(int paymentId);
  Future<BookingModel> getBookingDetails(int bookingId);
  Future<PaginationResponse<SessionModel>> getBookingList(
      BookingQueryModel bookingQueryModel);
}

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingRepositoryImpl(BookingRemoteDataSource bookingRemoteDataSource)
      : _remoteDataSource = bookingRemoteDataSource;

  @override
  Future<void> addBookingAddress(int addressId) =>
      _remoteDataSource.addBookingAddress(addressId);

  @override
  Future<void> addBookingMembers(List<int> members) =>
      _remoteDataSource.addBookingMembers(members);

  @override
  Future<void> addBookingService(ServiceBookModel serviceBookModel) =>
      _remoteDataSource.addBookingService(serviceBookModel);
  @override
  Future<void> addBookingTherapist(
          {required int therapistId, required DateTime availableTime}) =>
      _remoteDataSource.addBookingTherapist(
          therapistId: therapistId, availableTime: availableTime);

  @override
  Future<BookingModel> addBookingVoucher(String voucherId) =>
      _remoteDataSource.addBookingVoucher(voucherId);

  @override
  Future<void> confirmBooking(int paymentId) =>
      _remoteDataSource.confirmBooking(paymentId);

  @override
  Future<BookingModel> deleteBookingVoucher(String voucherId) =>
      _remoteDataSource.deleteBookingVoucher(voucherId);

  @override
  Future<BookingModel> getBookingDetails(int bookingId) =>
      _remoteDataSource.getBookingDetails(bookingId);

  @override
  Future<int> getBookingLatestId() => _remoteDataSource.getBookingLatestId();

  @override
  Future<PaginationResponse<SessionModel>> getBookingList(
      BookingQueryModel bookingQueryModel) async {
    return await _remoteDataSource.getBookingList(bookingQueryModel);
  }
}
