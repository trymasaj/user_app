import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/models/select_language_model.dart';
import '/core/app_export.dart';
part 'select_language_event.dart';
part 'select_language_state.dart';

/// A bloc that manages the state of a SelectLanguage according to the event that is dispatched to it.
class SelectLanguageBloc
    extends Bloc<SelectLanguageEvent, SelectLanguageState> {
  SelectLanguageBloc(SelectLanguageState initialState) : super(initialState) {
    on<SelectLanguageInitialEvent>(_onInitialize);
    on<ChangeRadioButtonEvent>(_changeRadioButton);
  }

  _changeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<SelectLanguageState> emit,
  ) {
    emit(state.copyWith(
      chooseYourPreferredLanguage: event.value,
    ));
  }

  List<String> fillRadioList() {
    return ["lbl_arabic", "lbl_english"];
  }

  _onInitialize(
    SelectLanguageInitialEvent event,
    Emitter<SelectLanguageState> emit,
  ) async {
    emit(state.copyWith(
      chooseYourPreferredLanguage: "",
    ));
    emit(state.copyWith(
        selectLanguageModelObj: state.selectLanguageModelObj?.copyWith(
      radioList: fillRadioList(),
    )));
  }
}
