import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_event.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_state.dart';

/// A bloc that manages the state of a SettingsSubscribedToMasajPlus according to the event that is dispatched to it.
class SettingsBloc extends BaseCubit<SettingsState> {
  SettingsBloc(super.initialState);

  // Future<void> changeSwitch(bool value) async {
  //   emit(state.copyWith(isSelectedSwitch: value));
  // }

  Future<void> _onInitialize(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isSelectedSwitch: false));
  }
}
