// ignore_for_file: must_be_immutable

part of 'settings_subscribed_to_masaj_plus_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SettingsSubscribedToMasajPlus widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SettingsSubscribedToMasajPlusEvent extends Equatable {}

/// Event that is dispatched when the SettingsSubscribedToMasajPlus widget is first created.
class SettingsSubscribedToMasajPlusInitialEvent
    extends SettingsSubscribedToMasajPlusEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing switch
class ChangeSwitchEvent extends SettingsSubscribedToMasajPlusEvent {
  ChangeSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
