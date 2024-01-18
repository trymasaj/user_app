// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:masaj/features/settings_tab/models/settings_model.dart';

/// Represents the state of SettingsSubscribedToMasajPlus in the application.
class SettingsState extends Equatable {
  SettingsState({
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

  SettingsState copyWith({
    bool? isSelectedSwitch,
    SettingsSubscribedToMasajPlusModel? settingsSubscribedToMasajPlusModelObj,
  }) {
    return SettingsState(
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      settingsSubscribedToMasajPlusModelObj:
          settingsSubscribedToMasajPlusModelObj ??
              this.settingsSubscribedToMasajPlusModelObj,
    );
  }
}
