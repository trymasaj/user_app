import 'dart:developer';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';
import 'package:masaj/features/membership/data/repo/membership_repo.dart';

part 'membership_state.dart';

class MembershipCubit extends BaseCubit<MembershipState> {
  MembershipCubit({
    required MembershipRepository membershipRepository,
  })  : _membershipRepository = membershipRepository,
        super(const MembershipState());

  final MembershipRepository _membershipRepository;

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
}
