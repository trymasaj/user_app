import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/bookings_tab/data/models/review_reponse.dart';
import 'package:masaj/features/bookings_tab/data/models/review_request.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewModel> addReview(ReviewRequest reviewRequest);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final NetworkService _networkService;

  ReviewRemoteDataSourceImpl(this._networkService);

  @override
  Future<ReviewModel> addReview(ReviewRequest reviewRequest) {
    return _networkService
        .post('${ApiEndPoint.BOOKING}/${reviewRequest.bookingId}/review',
            data: reviewRequest.toMap())
        .then((response) {

      if (response.statusCode != 200)
        throw RequestException(message: response.data['detail']);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(message: result['msg']);
      return ReviewModel.fromMap(result);
    });
  }
}
