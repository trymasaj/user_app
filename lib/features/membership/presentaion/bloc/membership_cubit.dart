import 'dart:developer';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';
import 'package:masaj/features/membership/data/repo/membership_repo.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';

part 'membership_state.dart';

class MembershipCubit extends BaseCubit<MembershipState> {
  MembershipCubit({
    required MembershipRepository membershipRepository,
  })  : _membershipRepository = membershipRepository,
        super(const MembershipState());

  final MembershipRepository _membershipRepository;

  void init() async {
    await getSubscription();
    if (state.selectedSubscription?.id == 0) {
      getSubscriptionPlans();
    }
  }

  Future<void> getSubscription() async {
    emit(state.copyWith(status: MembershipStateStatus.loading));
    try {
      final selectedSubscription =
          await _membershipRepository.getSubscription();
      emit(state.copyWith(
          status: MembershipStateStatus.loaded,
          selectedSubscription: selectedSubscription));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembershipStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> purchaseSubscription(
      {int? planId,
      PaymentMethodModel? paymentMethod,
      bool? fromWallet}) async {
    if (planId == null || paymentMethod == null || fromWallet == null) return;
    emit(state.copyWith(status: MembershipStateStatus.loading));
    try {
      final selectedSubscription =
          await _membershipRepository.purchaseSubscription(
        paymentMethodEnum: paymentMethod,
        planId: planId,
        fromWallet: fromWallet,
      );
      emit(state.copyWith(
          status: MembershipStateStatus.loaded,
          selectedSubscription: selectedSubscription));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembershipStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getSubscriptionPlans() async {
    emit(state.copyWith(status: MembershipStateStatus.loading));
    try {
      final plans = await _membershipRepository.getSubscriptionPlans();
      emit(state.copyWith(status: MembershipStateStatus.loaded, plans: plans));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembershipStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> cancelSubscriptionPlans() async {
    emit(state.copyWith(status: MembershipStateStatus.loading));
    try {
      await _membershipRepository.deleteSubscription();
      emit(state.copyWith(status: MembershipStateStatus.deleted));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembershipStateStatus.error, errorMessage: e.toString()));
    }
  }
}
