// ignore_for_file: must_be_immutable

part of 'conditions_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Conditions widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ConditionsEvent extends Equatable {}

/// Event that is dispatched when the Conditions widget is first created.
class ConditionsInitialEvent extends ConditionsEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
class ChangeCheckBoxEvent extends ConditionsEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox1Event extends ConditionsEvent {
  ChangeCheckBox1Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox2Event extends ConditionsEvent {
  ChangeCheckBox2Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox3Event extends ConditionsEvent {
  ChangeCheckBox3Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox4Event extends ConditionsEvent {
  ChangeCheckBox4Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox5Event extends ConditionsEvent {
  ChangeCheckBox5Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///Event for changing checkbox
class ChangeCheckBox6Event extends ConditionsEvent {
  ChangeCheckBox6Event({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
