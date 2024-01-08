// ignore_for_file: must_be_immutable


import 'package:equatable/equatable.dart';
import 'package:masaj/features/legal/models/privacy_policy_model.dart';

/// Represents the state of PrivacyPolicy in the application.
class PrivacyPolicyState extends Equatable {
  PrivacyPolicyState({this.privacyPolicyModelObj});

  PrivacyPolicyModel? privacyPolicyModelObj;

  @override
  List<Object?> get props => [
        privacyPolicyModelObj,
      ];
  PrivacyPolicyState copyWith({PrivacyPolicyModel? privacyPolicyModelObj}) {
    return PrivacyPolicyState(
      privacyPolicyModelObj:
          privacyPolicyModelObj ?? this.privacyPolicyModelObj,
    );
  }
}
