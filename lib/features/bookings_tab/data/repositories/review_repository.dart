import 'package:masaj/features/bookings_tab/data/datasources/review_remote_data_source.dart';
import 'package:masaj/features/bookings_tab/data/models/review_request.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewRequest reviewRequest);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  ReviewRepositoryImpl(ReviewRemoteDataSource reviewRemoteDataSource)
      : _remoteDataSource = reviewRemoteDataSource;

  @override
  Future<void> addReview(ReviewRequest reviewRequest) =>
      _remoteDataSource.addReview(reviewRequest);
}
