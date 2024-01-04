// ignore_for_file: must_be_immutable

part of 'settings_subscribed_to_masaj_plus_bloc.dart';

/// Represents the state of SettingsSubscribedToMasajPlus in the application.
class SettingsSubscribedToMasajPlusState extends Equatable {
  SettingsSubscribedToMasajPlusState({
    this.isSelectedSwitch = false,
    this.settingsSubscribedToMasajPlusModelObj,
  });

  SettingsSubscribedToMasajPlusModel? settingsSubscribedToMasajPlusModelObj;

  bool isSelectedSwitch;

  @override
  List<Object?> get props => [
        isSelectedSwitch,
        settingsSubscribedToMasajPlusModelObj,
      ];
  SettingsSubscribedToMasajPlusState copyWith({
    bool? isSelectedSwitch,
    SettingsSubscribedToMasajPlusModel? settingsSubscribedToMasajPlusModelObj,
  }) {
    return SettingsSubscribedToMasajPlusState(
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      settingsSubscribedToMasajPlusModelObj:
          settingsSubscribedToMasajPlusModelObj ??
              this.settingsSubscribedToMasajPlusModelObj,
    );
  }
}
