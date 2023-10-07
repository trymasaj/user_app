import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/topics_model.dart';
import '../../../data/repositories/account_repository.dart';

part 'about_us_state.dart';

class AboutUsCubit extends BaseCubit<AboutUsState> {
  AboutUsCubit(this._accountRepository) : super(const AboutUsState());

  final AccountRepository _accountRepository;

  Future<void> getAboutUsData([bool refresh = false]) async {
    final Topic aboutUsData;
    try {
      if (!refresh) emit(state.copyWith(status: AboutUsStateStatus.loading));

      aboutUsData = await _accountRepository.getAboutUs();
      emit(state.copyWith(
          status: AboutUsStateStatus.loaded, aboutUsData: aboutUsData));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AboutUsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => getAboutUsData(true);
}
