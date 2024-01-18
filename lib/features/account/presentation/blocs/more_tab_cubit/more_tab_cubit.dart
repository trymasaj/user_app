import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';

import 'package:masaj/core/domain/enums/show_case_displayed_page.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/features/account/data/models/external_item_model.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';

import 'package:masaj/core/data/device/app_info_service.dart';
import 'package:masaj/core/data/device/launcher_service.dart';

part 'more_tab_state.dart';

class MoreTabCubit extends BaseCubit<MoreTabState> {
  MoreTabCubit({
    required AccountRepository accountRepository,
    required LauncherService launcherService,
    required AppInfoService appInfoService,
    required ShowCaseHelper showCaseHelper,
  })  : _accountRepository = accountRepository,
        _launcherService = launcherService,
        _appInfoService = appInfoService,
        _showCaseHelper = showCaseHelper,
        super(const MoreTabState());

  final AccountRepository _accountRepository;
  final LauncherService _launcherService;
  final AppInfoService _appInfoService;
  final ShowCaseHelper _showCaseHelper;

  Future<void> init() => loadExternalSection().whenComplete(_initShowCase);

  Future<void> loadExternalSection([bool refresh = false]) async {
    final appInfo = refresh ? null : await _appInfoService.init();
    try {
      if (!refresh) {
        emit(const MoreTabState(status: MoreTabStateStatus.loading));
      }
      final externalSection = await _accountRepository.getExternalSection();
      emit(MoreTabState(
        status: MoreTabStateStatus.loaded,
        externalSection: externalSection,
        appInfo: appInfo == null
            ? null
            : '${appInfo.version} - ${appInfo.buildNumber}',
      ));
    } on Exception catch (e) {
      emit(MoreTabState(
        status: MoreTabStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh() => loadExternalSection(true);

  void openWebsite(String url) {
    _launcherService.openWebsite(url);
  }

  Future<void> _initShowCase() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (state.status != MoreTabStateStatus.loaded) return;

    final alreadyDisplayed = await _showCaseHelper
        .checkShowCaseAlreadyDisplayed(ShowCaseDisplayedPage.MoreTab);

    if (alreadyDisplayed) return;

    emit(state.copyWith(status: MoreTabStateStatus.displayingShowCase));
  }

  Future<void> finishShowCase() async {
    await _showCaseHelper.setShowCaseDisplayed(ShowCaseDisplayedPage.MoreTab);
    emit(state.copyWith(status: MoreTabStateStatus.loaded));
  }
}
