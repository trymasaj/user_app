// ignore_for_file: must_be_immutable

part of 'medical_form_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MedicalForm widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MedicalFormEvent extends Equatable {}

/// Event that is dispatched when the MedicalForm widget is first created.
class MedicalFormInitialEvent extends MedicalFormEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends MedicalFormEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}
