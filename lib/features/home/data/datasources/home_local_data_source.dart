import 'package:masaj/core/data/clients/cache_manager.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

abstract class HomeLocalDatasource {
  Future<bool> saveRecentService(ServiceModel service);
  Future<bool> saveSearchResult(SearchResultModel service);
  Future<List<SearchResultModel>> getRecentSearchResults();
  Future<bool> removeRecentSearchResult(
    SearchResultModel service,
  );
  Future<List<ServiceModel>> getRecentServices();
  Future<bool> removeRecentService(
    ServiceModel service,
  );
  Future<bool> saveSearchKeyWord(String keyWord);
  // get search key words
  Future<List<String>> getSearchKeyWords();
  // remove search key word
  Future<bool> removeSearchKeyWord(String keyWord);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final CacheManager _cacheService;

  HomeLocalDatasourceImpl(this._cacheService);

  @override
  Future<List<ServiceModel>> getRecentServices() async {
    return _cacheService.getAllServiceModels();
  }

  @override
  Future<bool> saveRecentService(ServiceModel service) {
    return _cacheService.saveServiceModel(service);
  }

  @override
  Future<bool> removeRecentService(ServiceModel service) async {
    return _cacheService.removeServiceModel(service);
  }

  @override
  Future<List<SearchResultModel>> getRecentSearchResults() async {
    return _cacheService.getAllSearchResultModels();
  }

  @override
  Future<bool> removeRecentSearchResult(SearchResultModel service) async {
    return _cacheService.removeSearchResultModel(service);
  }

  @override
  Future<bool> saveSearchResult(SearchResultModel service) async {
    return _cacheService.saveSearchResultModel(service);
  }
  
  @override
  Future<List<String>> getSearchKeyWords() async{
    return _cacheService.getSearchKeyWords();
  }
  
  @override
  Future<bool> removeSearchKeyWord(String keyWord) async{
    return _cacheService.removeSearchKeyWord(keyWord);
  }
  
  @override
  Future<bool> saveSearchKeyWord(String keyWord) async{
    return _cacheService.saveSearchKeyWord(keyWord);
  }
}
