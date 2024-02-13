import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/intro/data/repositories/intro_repository.dart';

part 'choose_language_state.dart';

class ChooseLanguageCubit extends BaseCubit<ChooseLanguageState> {
  ChooseLanguageCubit(this._introRepository)
      : super(const ChooseLanguageState());

  final IntroRepository _introRepository;

  Future<void> saveLanguageCode(String languageCode) async {
    emit(state.copyWith(status: ChooseLanguageStateStatus.loading));
    try {
      await _introRepository.setLanguageCode(languageCode);
      emit(state.copyWith(status: ChooseLanguageStateStatus.languageSet));
    } catch (e) {
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> saveLanguageCodeFromSetting(String languageCode) async {
    emit(state.copyWith(status: ChooseLanguageStateStatus.loading));
    try {
      await _introRepository.setLanguageCode(languageCode);
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.languageSetFromSetting));
    } catch (e) {
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.error, errorMessage: e.toString()));
    }
  }
}
