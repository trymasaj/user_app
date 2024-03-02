import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/settings_tab/models/select_language_model.dart';

part 'select_language_state.dart';

/// A bloc that manages the state of a SelectLanguage according to the event that is dispatched to it.
class SelectLanguageBloc extends Cubit<SelectLanguageState> {
  SelectLanguageBloc(super.initialState) {
    final deviclLocal = Platform.localeName;
    changeRadioButton('ar');
  }
  // get the device local language

  changeRadioButton(
    String value,
  ) {
    emit(state.copyWith(
      chooseYourPreferredLanguage: value,
    ));
    print('value $value');
  }

  _onInitialize() async {}
}
