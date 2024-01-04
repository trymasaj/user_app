// ignore_for_file: must_be_immutable

part of 'my_profile_bloc.dart';

/// Represents the state of MyProfile in the application.
class MyProfileState extends Equatable {
  MyProfileState({
    this.nameFloatingTextFieldController,
    this.emailFloatingTextFieldController,
    this.myProfileModelObj,
  });

  TextEditingController? nameFloatingTextFieldController;

  TextEditingController? emailFloatingTextFieldController;

  MyProfileModel? myProfileModelObj;

  @override
  List<Object?> get props => [
        nameFloatingTextFieldController,
        emailFloatingTextFieldController,
        myProfileModelObj,
      ];
  MyProfileState copyWith({
    TextEditingController? nameFloatingTextFieldController,
    TextEditingController? emailFloatingTextFieldController,
    MyProfileModel? myProfileModelObj,
  }) {
    return MyProfileState(
      nameFloatingTextFieldController: nameFloatingTextFieldController ??
          this.nameFloatingTextFieldController,
      emailFloatingTextFieldController: emailFloatingTextFieldController ??
          this.emailFloatingTextFieldController,
      myProfileModelObj: myProfileModelObj ?? this.myProfileModelObj,
    );
  }
}
