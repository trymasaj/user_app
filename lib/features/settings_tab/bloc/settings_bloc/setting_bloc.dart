import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_event.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_state.dart';
import '/core/app_export.dart';

/// A bloc that manages the state of a SettingsSubscribedToMasajPlus according to the event that is dispatched to it.
class SettingsBloc extends Bloc<
    SettingsSubscribedToMasajPlusEvent, SettingsState> {
  SettingsBloc(
      SettingsState initialState)
      : super(initialState) {
    on<SettingsEvent>(_onInitialize);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

  Future<void> _changeSwitch(
      ChangeSwitchEvent event,
      Emitter<SettingsState> emit,
      ) async {
    emit(state.copyWith(isSelectedSwitch: event.value));
  }

  Future<void> _onInitialize(
      SettingsEvent event,
      Emitter<SettingsState> emit,
      ) async {
    emit(state.copyWith(isSelectedSwitch: false));
  }
}
