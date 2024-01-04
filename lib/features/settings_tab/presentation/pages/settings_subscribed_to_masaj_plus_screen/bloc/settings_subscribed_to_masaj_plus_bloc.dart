import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/features/settings_tab/presentation/pages/settings_subscribed_to_masaj_plus_screen/models/settings_subscribed_to_masaj_plus_model.dart';
import '/core/app_export.dart';
part 'settings_subscribed_to_masaj_plus_event.dart';
part 'settings_subscribed_to_masaj_plus_state.dart';

/// A bloc that manages the state of a SettingsSubscribedToMasajPlus according to the event that is dispatched to it.
class SettingsSubscribedToMasajPlusBloc extends Bloc<
    SettingsSubscribedToMasajPlusEvent, SettingsSubscribedToMasajPlusState> {
  SettingsSubscribedToMasajPlusBloc(
      SettingsSubscribedToMasajPlusState initialState)
      : super(initialState) {
    on<SettingsSubscribedToMasajPlusInitialEvent>(_onInitialize);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

  Future<void> _changeSwitch(
    ChangeSwitchEvent event,
    Emitter<SettingsSubscribedToMasajPlusState> emit,
  ) async {
    emit(state.copyWith(isSelectedSwitch: event.value));
  }

  Future<void> _onInitialize(
    SettingsSubscribedToMasajPlusInitialEvent event,
    Emitter<SettingsSubscribedToMasajPlusState> emit,
  ) async {
    emit(state.copyWith(isSelectedSwitch: false));
  }
}
