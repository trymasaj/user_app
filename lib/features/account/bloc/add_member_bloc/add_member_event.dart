// ignore_for_file: must_be_immutable

part of 'add_member_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///AddMember widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class AddMemberEvent extends Equatable {}

/// Event that is dispatched when the AddMember widget is first created.
class AddMemberInitialEvent extends AddMemberEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing country code
class ChangeCountryEvent extends AddMemberEvent {
  ChangeCountryEvent({required this.value});

  Country value;

  @override
  List<Object?> get props => [
        value,
      ];
}
