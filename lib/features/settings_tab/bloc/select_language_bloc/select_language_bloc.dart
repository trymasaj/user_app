import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/models/select_language_model.dart';
import '/core/app_export.dart';
part 'select_language_state.dart';

/// A bloc that manages the state of a SelectLanguage according to the event that is dispatched to it.
class SelectLanguageBloc extends Cubit<SelectLanguageState> {
  SelectLanguageBloc(SelectLanguageState initialState) : super(initialState) {}

  changeRadioButton(
    String value,
  ) {
    emit(state.copyWith(
      chooseYourPreferredLanguage: value,
    ));
  }

  _onInitialize() async {}
}
