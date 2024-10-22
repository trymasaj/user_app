import 'package:masaj/core/data/clients/cache_manager.dart';
import 'package:masaj/core/domain/enums/show_case_displayed_page.dart';

class ShowCaseHelper {
  final CacheManager _cacheService;

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
