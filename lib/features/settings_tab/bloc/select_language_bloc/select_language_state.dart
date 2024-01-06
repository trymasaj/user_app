// ignore_for_file: must_be_immutable

part of 'select_language_bloc.dart';

/// Represents the state of SelectLanguage in the application.
class SelectLanguageState extends Equatable {
  SelectLanguageState({
    this.chooseYourPreferredLanguage = "",
    this.selectLanguageModelObj,
  });

  SelectLanguageModel? selectLanguageModelObj;

  String chooseYourPreferredLanguage;

  @override
  List<Object?> get props => [
        chooseYourPreferredLanguage,
        selectLanguageModelObj,
      ];
  SelectLanguageState copyWith({
    String? chooseYourPreferredLanguage,
    SelectLanguageModel? selectLanguageModelObj,
  }) {
    return SelectLanguageState(
      chooseYourPreferredLanguage:
          chooseYourPreferredLanguage ?? this.chooseYourPreferredLanguage,
      selectLanguageModelObj:
          selectLanguageModelObj ?? this.selectLanguageModelObj,
    );
  }
}
