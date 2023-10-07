import '../../../../core/enums/topic_type.dart';
import '../models/points_model.dart';

import '../../../../core/data/models/coupon_model.dart';
import '../datasources/account_remote_data_source.dart';
import '../models/contact_us_message_model.dart';
import '../models/external_item_model.dart';
import '../models/redeem_coupon_result.dart';
import '../models/topics_model.dart';

abstract class AccountRepository {
  Future<Topic> getAboutUs();
  Future<void> sendContactUsMessage(ContactUsMessage data);
  Future<Topic?> getTopicsData(TopicType id);
  Future<List<ExternalItemModel>> getExternalSection();

  Future<Coupon> getAllCoupons({
    int? cursor,
    int pageSize = 10,
  });
  Future<Coupon> getRedeemedCoupons({
    int? cursor,
    int pageSize = 10,
  });

  Future<CouponItem> getCouponDetails(int id);
  Future<String> getCouponCode(int id);

  Future<PointsModel> getUserPoints();
  Future<PointsModel> getMorePoints(int cursor);

  Future<RedeemCouponResult> redeemCoupon(int id);
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource _remoteDataSource;

  AccountRepositoryImpl({
    required AccountRemoteDataSource accountRemoteDataSource,
  }) : _remoteDataSource = accountRemoteDataSource;

  @override
  Future<Topic> getAboutUs() => _remoteDataSource.getAboutUs();

  @override
  Future<void> sendContactUsMessage(ContactUsMessage data) =>
      _remoteDataSource.sendContactUsMessage(data);

  @override
  Future<Topic?> getTopicsData(TopicType id) =>
      _remoteDataSource.getTopicData(id);

  @override
  Future<List<ExternalItemModel>> getExternalSection() =>
      _remoteDataSource.getExternalSection();

  @override
  Future<Coupon> getAllCoupons({
    int? cursor,
    int pageSize = 10,
  }) =>
      _remoteDataSource.getAllCoupons(cursor: cursor, pageSize: pageSize);

  @override
  Future<Coupon> getRedeemedCoupons({
    int? cursor,
    int pageSize = 10,
  }) =>
      _remoteDataSource.getRedeemedCoupons(cursor: cursor, pageSize: pageSize);

  @override
  Future<RedeemCouponResult> redeemCoupon(int id) =>
      _remoteDataSource.redeemCoupon(id);

  @override
  Future<PointsModel> getUserPoints() => _remoteDataSource.getUserPoints();

  @override
  Future<PointsModel> getMorePoints(int cursor) =>
      _remoteDataSource.getMorePoints(cursor);

  @override
  Future<CouponItem> getCouponDetails(int id) =>
      _remoteDataSource.getCouponDetails(id);

  @override
  Future<String> getCouponCode(int id) => _remoteDataSource.getCouponCode(id);
}
