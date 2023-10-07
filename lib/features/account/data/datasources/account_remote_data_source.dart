import '../../../../api_end_point.dart';
import '../../../../core/data/models/coupon_model.dart';
import '../../../../core/enums/request_result_enum.dart';
import '../../../../core/enums/topic_type.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';
import '../models/contact_us_message_model.dart';
import '../models/external_item_model.dart';
import '../models/points_model.dart';
import '../models/redeem_coupon_result.dart';
import '../models/topics_model.dart';

abstract class AccountRemoteDataSource {
  Future<Topic> getAboutUs();
  Future<void> sendContactUsMessage(ContactUsMessage data);
  Future<Topic?> getTopicData(TopicType id);
  Future<List<ExternalItemModel>> getExternalSection();

  Future<Coupon> getAllCoupons({
    int? cursor,
    int pageSize = 10,
  });
  Future<Coupon> getRedeemedCoupons({
    int? cursor,
    int pageSize = 10,
  });

  Future<RedeemCouponResult> redeemCoupon(int id);

  Future<PointsModel> getUserPoints();

  Future<PointsModel> getMorePoints(int cursor);

  Future<CouponItem> getCouponDetails(int id);

  Future<String> getCouponCode(int id);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final NetworkService _networkService;
  AccountRemoteDataSourceImpl(this._networkService);

  @override
  Future<Topic> getAboutUs() async {
    const url = ApiEndPoint.TOPICS_DATA;
    final params = {"blockType": TopicType.AboutUs.value};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return Topic.fromMap(result['data']);
    });
  }

  @override
  Future<void> sendContactUsMessage(ContactUsMessage data) {
    const url = ApiEndPoint.CONTACT_US;
    return _networkService.post(url, data: data.toMap()).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
    });
  }

  @override
  Future<Topic?> getTopicData(TopicType id) async {
    const url = ApiEndPoint.TOPICS_DATA;

    return _networkService
        .get(url, queryParameters: {"type": id.value}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return Topic.fromMap(result['data']);
    });
  }

  @override
  Future<List<ExternalItemModel>> getExternalSection() {
    const url = ApiEndPoint.EXTERNAL_SECTION;

    return _networkService.get(url).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      final data = result['data'] as List;
      return data.map((e) => ExternalItemModel.fromMap(e)).toList();
    });
  }

  @override
  Future<Coupon> getAllCoupons({
    int? cursor,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.ALL_COUPON;

    final params = {'cursor': cursor, 'pageSize': pageSize}
      ..removeWhere((_, v) => v == null);

    return _networkService.get(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      final data = result['data'];
      return Coupon.fromMap(data);
    });
  }

  @override
  Future<Coupon> getRedeemedCoupons({
    int? cursor,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.REDEEMED_COUPON;

    final params = {'cursor': cursor, 'pageSize': pageSize}
      ..removeWhere((_, v) => v == null);

    return _networkService.get(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      final data = result['data'];
      return Coupon.fromMap(data);
    });
  }

  @override
  Future<RedeemCouponResult> redeemCoupon(int id) {
    const url = ApiEndPoint.REDEEM_COUPON;

    final params = {'couponId': id};

    return _networkService.post(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);

      return RedeemCouponResult.fromMap(result['data']);
    });
  }

  @override
  Future<PointsModel> getUserPoints() {
    const url = ApiEndPoint.GET_USER_POINTS;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return PointsModel.fromMap(result['data']);
    });
  }

  @override
  Future<PointsModel> getMorePoints(int cursor) {
    const url = ApiEndPoint.GET_MORE_USER_POINTS;

    final params = {"cursor": cursor};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return PointsModel.fromMap(result['data']);
    });
  }

  @override
  Future<CouponItem> getCouponDetails(int id) {
    const url = ApiEndPoint.GET_COUPON_DETAILS;

    final params = {"couponId": id};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return CouponItem.fromMap(result['data']);
    });
  }

  @override
  Future<String> getCouponCode(int id) {
    const url = ApiEndPoint.GET_COUPON_CODE;

    final params = {"couponId": id};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name)
        throw RequestException(result['msg']);
      return result['data'];
    });
  }
}
