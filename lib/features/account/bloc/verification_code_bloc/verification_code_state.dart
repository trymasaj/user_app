// ignore_for_file: must_be_immutable

part of 'verification_code_bloc.dart';

/// Represents the state of VerificationCode in the application.
class VerificationCodeState extends Equatable {
  const VerificationCodeState({
    required this.otp,
  });

  final String otp;

  @override
  List<Object?> get props => [
        otp,
      ];

  VerificationCodeState copyWith({
    String? otp,
  }) {
    return VerificationCodeState(
      otp: otp ?? this.otp,
    );
  }

  factory VerificationCodeState.initial() {
    return VerificationCodeState(
      otp: '',
    );
  }
}
