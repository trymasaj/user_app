import 'package:masaj/core/service/cache_service.dart';

import '../enums/show_case_displayed_page.dart';

class ShowCaseHelper {
  final CacheService _cacheService;

  ShowCaseHelper(this._cacheService);

  Future<bool> checkShowCaseAlreadyDisplayed(ShowCaseDisplayedPage page) async {
    final alreadyDisplayedPages =
        await _cacheService.getShowCaseDisplayedPages();
    return alreadyDisplayedPages.contains(page);
  }

  Future<void> setShowCaseDisplayed(ShowCaseDisplayedPage page) =>
      _cacheService.addShowCaseDisplayedPages(page);

  Future<void> resetShowCaseDisplayed() =>
      _cacheService.resetShowCaseDisplayedPages();
}
