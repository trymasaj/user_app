// ignore_for_file: must_be_immutable

part of 'select_language_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SelectLanguage widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SelectLanguageEvent extends Equatable {}

/// Event that is dispatched when the SelectLanguage widget is first created.
class SelectLanguageInitialEvent extends SelectLanguageEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing radio button
class ChangeRadioButtonEvent extends SelectLanguageEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}
