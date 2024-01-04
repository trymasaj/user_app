// ignore_for_file: must_be_immutable

part of 'phone_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Phone widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PhoneEvent extends Equatable {}

/// Event that is dispatched when the Phone widget is first created.
class PhoneInitialEvent extends PhoneEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing country code
class ChangeCountryEvent extends PhoneEvent {
  ChangeCountryEvent({required this.value});

  Country value;

  @override
  List<Object?> get props => [
        value,
      ];
}
