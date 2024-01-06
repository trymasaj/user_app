// ignore_for_file: must_be_immutable

part of 'add_new_address_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///AddNewAddress widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class AddNewAddressEvent extends Equatable {}

/// Event that is dispatched when the AddNewAddress widget is first created.
class AddNewAddressInitialEvent extends AddNewAddressEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing switch
class ChangeSwitchEvent extends AddNewAddressEvent {
  ChangeSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
