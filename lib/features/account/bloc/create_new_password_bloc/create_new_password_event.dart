// ignore_for_file: must_be_immutable

part of 'create_new_password_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CreateNewPasswordOne widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CreateNewPasswordOneEvent extends Equatable {}

/// Event that is dispatched when the CreateNewPasswordOne widget is first created.
class CreateNewPasswordOneInitialEvent extends CreateNewPasswordOneEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing password visibility
class ChangePasswordVisibilityEvent extends CreateNewPasswordOneEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing password visibility
class ChangePasswordVisibilityEvent1 extends CreateNewPasswordOneEvent {
  ChangePasswordVisibilityEvent1({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing password visibility
class ChangePasswordVisibilityEvent2 extends CreateNewPasswordOneEvent {
  ChangePasswordVisibilityEvent2({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
