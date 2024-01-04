// ignore_for_file: must_be_immutable

part of 'terms_and_condititons_bloc.dart';

/// Represents the state of TermsAndCondititons in the application.
class TermsAndCondititonsState extends Equatable {
  TermsAndCondititonsState({this.termsAndCondititonsModelObj});

  TermsAndCondititonsModel? termsAndCondititonsModelObj;

  @override
  List<Object?> get props => [
        termsAndCondititonsModelObj,
      ];
  TermsAndCondititonsState copyWith(
      {TermsAndCondititonsModel? termsAndCondititonsModelObj}) {
    return TermsAndCondititonsState(
      termsAndCondititonsModelObj:
          termsAndCondititonsModelObj ?? this.termsAndCondititonsModelObj,
    );
  }
}
