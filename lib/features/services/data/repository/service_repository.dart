import 'package:masaj/features/services/data/datasource/service_datasource.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';

abstract class ServiceRepository {
  Future<List<ServiceCategory>> getServiceCategories();
  Future<ServiceCategory> getSingleServiceCategory(int id);
  // service
  Future<List<ServiceModel>> getServices(ServiceQueryModel serviceQueryModel);
  Future<ServiceModel> getSingleService(int id);
}


class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource _serviceRemoteDataSource;

  ServiceRepositoryImpl(this._serviceRemoteDataSource);

  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    return await _serviceRemoteDataSource.getServiceCategories();
  }

  @override
  Future<ServiceCategory> getSingleServiceCategory(int id) async {
    return await _serviceRemoteDataSource.getSingleServiceCategory(id);
  }

  @override
  Future<List<ServiceModel>> getServices(
      ServiceQueryModel serviceQueryModel) async {
    return await _serviceRemoteDataSource.getServices(serviceQueryModel);
  }

  @override
  Future<ServiceModel> getSingleService(int id) async {
    return await _serviceRemoteDataSource.getSingleService(id);
  }
}