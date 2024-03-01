import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

abstract class HomeLocalDatasource {
  Future<bool> saveRecentService(ServiceModel service);
  Future<List<ServiceModel>> getRecentServices();
  Future<bool> removeRecentService(
    ServiceModel service,
  );
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final CacheService _cacheService;

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
}
