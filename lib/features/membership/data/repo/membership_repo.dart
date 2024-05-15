import 'package:masaj/core/domain/enums/payment_methods.dart';
import 'package:masaj/features/membership/data/datasource/membership_datasource.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';

abstract class MembershipRepository {
  Future<Plan> getSubscriptionPlans();
  Future<SubscriptionModel> getSubscription();
  Future<SubscriptionModel> purchaseSubscription(
      {required int planId,
      required PaymentMethodEnum paymentMethodEnum,
      required bool fromWallet});
  Future<void> deleteSubscription();
}

class MembershipRepositoryImp extends MembershipRepository {
  final MembershipDataSource _membershipDataSource;

  MembershipRepositoryImp({required MembershipDataSource membershipDataSource})
      : _membershipDataSource = membershipDataSource;

  @override
  Future<void> deleteSubscription() =>
      _membershipDataSource.deleteSubscription();

  @override
  Future<SubscriptionModel> getSubscription() =>
      _membershipDataSource.getSubscription();

  @override
  Future<Plan> getSubscriptionPlans() =>
      _membershipDataSource.getSubscriptionPlans();

  @override
  Future<SubscriptionModel> purchaseSubscription(
          {required int planId,
          required PaymentMethodEnum paymentMethodEnum,
          required bool fromWallet}) =>
      _membershipDataSource.purchaseSubscription(
          fromWallet: fromWallet,
          planId: planId,
          paymentMethodEnum: paymentMethodEnum);
}
