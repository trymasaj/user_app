import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';
import 'package:masaj/features/membership/data/repo/membership_repo.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/main.dart';

part 'membership_state.dart';

class MembershipCubit extends BaseCubit<MembershipState> {
  MembershipCubit({
    required MembershipRepository membershipRepository,
    required PaymentService paymentService,
  })  : _membershipRepository = membershipRepository,
        _paymentService = paymentService,
        super(const MembershipState());

  final MembershipRepository _membershipRepository;
  final PaymentService _paymentService;

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

  Future<void> purchaseSubscription(BuildContext context,
      {int? planId,
      PaymentMethodModel? paymentMethod,
      bool? fromWallet}) async {
    if (planId == null || paymentMethod == null || fromWallet == null) return;

    emit(state.copyWith(status: MembershipStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        urlPath: ApiEndPoint.MEMBERSHIP,
        params: {
          "planId": planId,
          "paymentMethod": paymentMethod.id,
          "walletPayment": fromWallet,
        },
        paymentMethodId: paymentMethod.id,
        onSuccess: () {
          navigatorKey.currentState!.pop();
          navigatorKey.currentState!.pop();
          showSnackBar(context, message: 'Plan upgraded successfully!');
        },
        onFailure: () {
          navigatorKey.currentState!.pop();
          showSnackBar(context, message: 'error_occurred'.tr());
        },
      ));
      emit(state.copyWith(status: MembershipStateStatus.loaded));
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
