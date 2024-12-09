import 'dart:developer';

import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/data/models/pagination_response.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

import '../../../book_service/data/models/booking_model/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<int> getBookingLatestId();
  Future<void> addBookingService(ServiceBookModel serviceBookModel);
  Future<BookingModel> addBookingMembers(List<int> members);
  Future<void> addBookingAddress(int addressId);
  Future<void> addBookingTherapist(
      {required int therapistId, required DateTime availableTime});
  Future<BookingModel> addBookingVoucher(String voucherId);
  Future<BookingModel> deleteBookingVoucher(String voucherId);
  Future<void> confirmBooking(int paymentId);
  Future<BookingModel> getBookingDetails(int bookingId);
  Future<int> getBookingStreaks();

  Future<PaginationResponse<SessionModel>> getBookingList(
      BookingQueryModel bookingQueryModel);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final NetworkService _networkService;

  BookingRemoteDataSourceImpl(this._networkService);

  @override
  Future<void> addBookingAddress(int addressId) {
    const url = ApiEndPoint.BOOKING_ADDRESS;
    final data = {'customerAddressId': addressId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
    });
  }

  @override
  Future<int> getBookingStreaks() {
    const url = ApiEndPoint.GET_BOOKING_STREAKS;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;
      return result['bookingStreakCount'];
    });
  }

  @override
  Future<BookingModel> addBookingMembers(List<int> members) async {
    const url = ApiEndPoint.BOOKING_MEMBERS;
    final data = {'memberIds': members};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;

      return BookingModel.fromMap(result);
    });
  }

  @override
  Future<void> addBookingService(ServiceBookModel serviceBookModel) {
    const url = ApiEndPoint.BOOKING_SERVICE;
    final data = serviceBookModel.toMap();

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
    });
  }

  @override
  Future<void> addBookingTherapist(
      {required int therapistId, required DateTime availableTime}) {
    const url = ApiEndPoint.BOOKING_THERAPIST;
    log(availableTime.toLocal().toIso8601String());
    final data = {
      'therapistId': therapistId,
      'bookingDate': availableTime.toLocal().toIso8601String(),
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
    });
  }

  @override
  Future<BookingModel> addBookingVoucher(String voucherId) {
    const url = ApiEndPoint.BOOKING_ADD_VOUCHER;
    final data = {'redemptionCode': voucherId};
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;

      return BookingModel.fromMap(result);
    });
  }

  @override
  Future<void> confirmBooking(int paymentId) {
    const url = ApiEndPoint.BOOKING_CONFIRM;
    final data = {'paymentMethod': paymentId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
    });
  }

  @override
  Future<BookingModel> deleteBookingVoucher(String voucherId) {
    const url = ApiEndPoint.BOOKING_REMOVE_VOUCHER;
    final data = {'redemptionCode': voucherId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;

      return BookingModel.fromMap(result);
    });
  }

  @override
  Future<int> getBookingLatestId() {
    const url = ApiEndPoint.BOOKING_LATEST;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      return response.data['bookingId'];
    });
  }

  @override
  Future<BookingModel> getBookingDetails(int bookingId) {
    const url = ApiEndPoint.BOOKING_DETAILS;

    return _networkService.get(url + bookingId.toString()).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;

      return BookingModel.fromMap(result);
    });
  }

  @override
  Future<PaginationResponse<SessionModel>> getBookingList(
      BookingQueryModel bookingQueryModel) async {
    const url = ApiEndPoint.BOOKING;
    final data = bookingQueryModel.toMap();
    return _networkService.get(url, queryParameters: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;
      return PaginationResponse.fromMap(result,
          mapperFunc: SessionModel.fromMap);
    });
  }
}
