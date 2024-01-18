// ignore_for_file: must_be_immutable

part of 'create_new_password_bloc.dart';

/// Represents the state of CreateNewPasswordOne in the application.
class CreateNewPasswordState extends Equatable {
  const CreateNewPasswordState({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  final String oldPassword;

  final String newPassword;

  final String confirmNewPassword;

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmNewPassword,
      ];
  CreateNewPasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return CreateNewPasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
    );
  }

  factory CreateNewPasswordState.initial() {
    return const CreateNewPasswordState(
      oldPassword: '',
      newPassword: '',
      confirmNewPassword: '',
    );
  }
}
