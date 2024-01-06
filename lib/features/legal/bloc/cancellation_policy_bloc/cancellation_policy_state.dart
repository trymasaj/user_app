// ignore_for_file: must_be_immutable

part of 'cancellation_policy_bloc.dart';

/// Represents the state of CancellationPolicy in the application.
class CancellationPolicyState extends Equatable {
  CancellationPolicyState({this.cancellationPolicyModelObj});

  CancellationPolicyModel? cancellationPolicyModelObj;

  @override
  List<Object?> get props => [
        cancellationPolicyModelObj,
      ];
  CancellationPolicyState copyWith(
      {CancellationPolicyModel? cancellationPolicyModelObj}) {
    return CancellationPolicyState(
      cancellationPolicyModelObj:
          cancellationPolicyModelObj ?? this.cancellationPolicyModelObj,
    );
  }
}
