part of 'choose_language_cubit.dart';

enum ChooseLanguageStateStatus { initial, loading, languageSet ,languageSetFromSetting , error }

class ChooseLanguageState {
  final ChooseLanguageStateStatus status;
  final String? errorMessage;

  const ChooseLanguageState({
    this.status = ChooseLanguageStateStatus.initial,
    this.errorMessage,
  });

  ChooseLanguageState copyWith({
    ChooseLanguageStateStatus? status,
    String? errorMessage,
  }) {
    return ChooseLanguageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'ChooseLanguageState(status: $status, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant ChooseLanguageState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  bool get isInitial => status == ChooseLanguageStateStatus.initial;

  bool get isLoading => status == ChooseLanguageStateStatus.loading;

  bool get isLanguageSet => status == ChooseLanguageStateStatus.languageSet;

  bool get isLanguageSetFromSetting => status == ChooseLanguageStateStatus.languageSetFromSetting;

  bool get isError => status == ChooseLanguageStateStatus.error;
}
