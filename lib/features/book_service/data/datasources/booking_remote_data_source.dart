import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

import '../../../book_service/data/models/booking_model/booking_model.dart';

abstract class BookingRemoteDataSource {
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

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final NetworkService _networkService;

  BookingRemoteDataSourceImpl(this._networkService);

  @override
  Future<void> addBookingAddress(int addressId) {
    const url = ApiEndPoint.BOOKING_LATEST;
    final data = {'customerAddressId': addressId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> addBookingMembers(List<int> members) {
    const url = ApiEndPoint.GET_HOME_PAGE_DATA;
    final data = {'memberIds': members};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> addBookingService(ServiceBookModel serviceBookModel) {
    const url = ApiEndPoint.BOOKING_LATEST;
    final data = serviceBookModel.toMap();

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> addBookingTherapist(
      {required int therapistId, required DateTime availableTime}) {
    const url = ApiEndPoint.BOOKING_LATEST;
    final data = {
      'therapistId': therapistId,
      'bookingDate': availableTime,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> addBookingVoucher(int voucherId) {
    const url = ApiEndPoint.BOOKING_ADD_VOUCHER;
    final data = {'redemptionCode': voucherId};
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> confirmBooking(int paymentId) {
    const url = ApiEndPoint.BOOKING_CONFIRM;
    final data = {'paymentMethod': paymentId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> deleteBookingVoucher(int voucherId) {
    const url = ApiEndPoint.BOOKING_REMOVE_VOUCHER;
    final data = {'redemptionCode': voucherId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<void> getBookingLatestId() {
    const url = ApiEndPoint.BOOKING_LATEST;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
    });
  }

  @override
  Future<BookingModel> getBookingDetails(int bookingId) {
    const url = ApiEndPoint.BOOKING_DETAILS;

    return _networkService.get(url + bookingId.toString()).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;

      return BookingModel.fromMap(result);
    });
  }
}
