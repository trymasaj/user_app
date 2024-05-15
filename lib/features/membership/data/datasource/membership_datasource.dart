// ignore_for_file: void_checks
import 'dart:developer';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/payment_methods.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';

abstract class MembershipDataSource {
  Future<Plan> getSubscriptionPlans();
  Future<SubscriptionModel> getSubscription();
  Future<SubscriptionModel> purchaseSubscription(
      {required int planId,
      required PaymentMethodEnum paymentMethodEnum,
      required bool fromWallet});
  Future<void> deleteSubscription();
}

class MembershipDataSourceImpl extends MembershipDataSource {
  final NetworkService _networkService;

  MembershipDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<Plan> getSubscriptionPlans() {
    const url = ApiEndPoint.MEMBERSHIP_PLANS;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;
      return Plan.fromMap(result);
    });
  }

  @override
  Future<SubscriptionModel> getSubscription() {
    const url = ApiEndPoint.MEMBERSHIP;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;

      return SubscriptionModel.fromMap(result);
    });
  }

  @override
  Future<SubscriptionModel> purchaseSubscription(
      {required int planId,
      required PaymentMethodEnum paymentMethodEnum,
      required bool fromWallet}) {
    const url = ApiEndPoint.MEMBERSHIP;
    final data = {
      "planId": planId,
      "paymentMethod": paymentMethodEnum,
      "walletPayment": fromWallet,
    };
    return _networkService
        .post(
      url,
      data: data,
    )
        .then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;
      return SubscriptionModel.fromMap(result);
    });
  }

  @override
  Future<void> deleteSubscription() {
    const url = ApiEndPoint.MEMBERSHIP;
    return _networkService.delete(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      log(response.data.toString());
    });
  }
}
