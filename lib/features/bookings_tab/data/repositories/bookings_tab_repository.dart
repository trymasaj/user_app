import 'package:masaj/features/bookings_tab/data/datasources/bookings_tab_remote_data_source.dart';
import 'package:masaj/features/bookings_tab/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

abstract class BookingsTabRepository {
  Future<void> getBookingLatestId();
  Future<void> addBookingService(ServiceBookModel serviceBookModel);
  Future<void> addBookingMembers(List<int> members);
  Future<void> addBookingAddress(int addressId);
  Future<void> addBookingTherapist(
      {required int therapistId, required DateTime availableTime});
  Future<void> addBookingVoucher(int voucherId);
  Future<void> deleteBookingVoucher(int voucherId);
  Future<void> confirmBooking(int paymentId);
  Future<BookingModel> getBookingDetails(int bookingId);
}

class BookingsTabRepositoryImpl implements BookingsTabRepository {
  final BookingsTabRemoteDataSource _remoteDataSource;

  BookingsTabRepositoryImpl({
    required BookingsTabRemoteDataSource bookings_tabRemoteDataSource,
  }) : _remoteDataSource = bookings_tabRemoteDataSource;

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
  Future<void> addBookingVoucher(int voucherId) =>
      _remoteDataSource.addBookingVoucher(voucherId);

  @override
  Future<void> confirmBooking(int paymentId) =>
      _remoteDataSource.confirmBooking(paymentId);

  @override
  Future<void> deleteBookingVoucher(int voucherId) =>
      _remoteDataSource.deleteBookingVoucher(voucherId);

  @override
  Future<BookingModel> getBookingDetails(int bookingId) =>
      _remoteDataSource.getBookingDetails(bookingId);

  @override
  Future<void> getBookingLatestId() => _remoteDataSource.getBookingLatestId();
}
