// ignore_for_file: must_be_immutable

part of 'create_new_password_bloc.dart';

/// Represents the state of CreateNewPasswordOne in the application.
class CreateNewPasswordOneState extends Equatable {
  CreateNewPasswordOneState({
    this.passwordEditTextController,
    this.newPasswordEditTextController,
    this.newPasswordEditTextController1,
    this.isShowPassword = true,
    this.isShowPassword1 = true,
    this.isShowPassword2 = true,
    this.createNewPasswordOneModelObj,
  });

  TextEditingController? passwordEditTextController;

  TextEditingController? newPasswordEditTextController;

  TextEditingController? newPasswordEditTextController1;

  CreateNewPasswordOneModel? createNewPasswordOneModelObj;

  bool isShowPassword;

  bool isShowPassword1;

  bool isShowPassword2;

  @override
  List<Object?> get props => [
        passwordEditTextController,
        newPasswordEditTextController,
        newPasswordEditTextController1,
        isShowPassword,
        isShowPassword1,
        isShowPassword2,
        createNewPasswordOneModelObj,
      ];
  CreateNewPasswordOneState copyWith({
    TextEditingController? passwordEditTextController,
    TextEditingController? newPasswordEditTextController,
    TextEditingController? newPasswordEditTextController1,
    bool? isShowPassword,
    bool? isShowPassword1,
    bool? isShowPassword2,
    CreateNewPasswordOneModel? createNewPasswordOneModelObj,
  }) {
    return CreateNewPasswordOneState(
      passwordEditTextController:
          passwordEditTextController ?? this.passwordEditTextController,
      newPasswordEditTextController:
          newPasswordEditTextController ?? this.newPasswordEditTextController,
      newPasswordEditTextController1:
          newPasswordEditTextController1 ?? this.newPasswordEditTextController1,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isShowPassword1: isShowPassword1 ?? this.isShowPassword1,
      isShowPassword2: isShowPassword2 ?? this.isShowPassword2,
      createNewPasswordOneModelObj:
          createNewPasswordOneModelObj ?? this.createNewPasswordOneModelObj,
    );
  }
}
