// ignore_for_file: must_be_immutable

part of 'reschedule_policy_bloc.dart';

/// Represents the state of ReschedulePolicy in the application.
class ReschedulePolicyState extends Equatable {
  ReschedulePolicyState({this.reschedulePolicyModelObj});

  ReschedulePolicyModel? reschedulePolicyModelObj;

  @override
  List<Object?> get props => [
        reschedulePolicyModelObj,
      ];

  ReschedulePolicyState copyWith(
      {ReschedulePolicyModel? reschedulePolicyModelObj}) {
    return ReschedulePolicyState(
      reschedulePolicyModelObj:
          reschedulePolicyModelObj ?? this.reschedulePolicyModelObj,
    );
  }
}
