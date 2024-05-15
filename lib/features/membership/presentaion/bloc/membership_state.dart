part of 'membership_cubit.dart';

enum MembershipStateStatus { initial, loading, loaded, error, deleted, added }

extension MembershipStateX on MembershipState {
  bool get isInitial => status == MembershipStateStatus.initial;
  bool get isLoading => status == MembershipStateStatus.loading;
  bool get isLoaded => status == MembershipStateStatus.loaded;
  bool get isError => status == MembershipStateStatus.error;
  bool get isDeleted => status == MembershipStateStatus.deleted;
  bool get isAdded => status == MembershipStateStatus.added;
}

class MembershipState {
  final MembershipStateStatus status;
  final Plan? plans;
  final SubscriptionModel? selectedSubscription;
  final String? errorMessage;

  const MembershipState({
    this.plans,
    this.selectedSubscription,
    this.status = MembershipStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as MembershipState).status == status &&
        other.plans == plans &&
        other.errorMessage == errorMessage &&
        other.selectedSubscription == selectedSubscription;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      plans.hashCode ^
      selectedSubscription.hashCode;

  MembershipState copyWith({
    MembershipStateStatus? status,
    String? errorMessage,
    SubscriptionModel? selectedSubscription,
    Plan? plans,
  }) {
    return MembershipState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedSubscription: selectedSubscription ?? this.selectedSubscription,
    );
  }
}
