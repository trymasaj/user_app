import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/cache_manager.dart';

part 'choose_language_state.dart';

class ChooseLanguageCubit extends BaseCubit<ChooseLanguageState> {
  ChooseLanguageCubit(this._cacheManager)
      : super(const ChooseLanguageState());

  final CacheManager _cacheManager;

  Future<void> saveLanguageCode(String languageCode) async {
    emit(state.copyWith(status: ChooseLanguageStateStatus.loading));
    try {
      await _cacheManager.setLanguageCode(languageCode);
      emit(state.copyWith(status: ChooseLanguageStateStatus.languageSet));
    } catch (e) {
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> saveLanguageCodeFromSetting(String languageCode) async {
    emit(state.copyWith(status: ChooseLanguageStateStatus.loading));
    try {
      await _cacheManager.setLanguageCode(languageCode);
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.languageSetFromSetting));
    } catch (e) {
      emit(state.copyWith(
          status: ChooseLanguageStateStatus.error, errorMessage: e.toString()));
    }
  }
}
