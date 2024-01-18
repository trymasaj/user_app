// ignore_for_file: must_be_immutable

part of 'legal_bloc.dart';

/// Represents the state of Legal in the application.
class LegalState extends Equatable {
  LegalState({this.legalModelObj});

  LegalModel? legalModelObj;

  @override
  List<Object?> get props => [
        legalModelObj,
      ];

  LegalState copyWith({LegalModel? legalModelObj}) {
    return LegalState(
      legalModelObj: legalModelObj ?? this.legalModelObj,
    );
  }
}
