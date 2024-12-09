import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_offer.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceCategory>> getServiceCategories();
  Future<ServiceCategory> getSingleServiceCategory(int id);
  // service
  Future<ServicesResponse> getServices(ServiceQueryModel serviceQueryModel);
  Future<ServiceModel> getSingleService(int id);
  Future<List<ServiceModel>> getRecommended();
  Future<List<ServiceOffer>> getOffers();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final NetworkService _networkService;

  ServiceRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    const url = ApiEndPoint.SERVICE_CATEGORIES;

    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    final List<ServiceCategory> serviceCategories = [];
    for (var item in response.data) {
      serviceCategories.add(ServiceCategory.fromMap(item));
    }

    return serviceCategories;
  }

  @override
  Future<ServicesResponse> getServices(
      ServiceQueryModel serviceQueryModel) async {
    const url = ApiEndPoint.SERVICES;
    // print(serviceQueryModel.toMap());
    final response = await _networkService.get(
      url,
      queryParameters: serviceQueryModel.toMap(),
      // 'https://stagingapi.trymasaj.com/masaj/services?Page=1&PageSize=10',
    );
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    return ServicesResponse.fromMap(response.data);
  }

  @override
  Future<ServiceModel> getSingleService(int id) async {
    final url = '${ApiEndPoint.SERVICES}/$id';

    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    return ServiceModel.fromMap(response.data);
  }

  @override
  Future<ServiceCategory> getSingleServiceCategory(int id) async {
    final url = '${ApiEndPoint.SERVICE_CATEGORIES}/$id';

    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    return ServiceCategory.fromMap(response.data);
  }

  @override
  Future<List<ServiceModel>> getRecommended() async {
    const url = ApiEndPoint.SERVICES_RECOMMENDED;

    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    final List<ServiceModel> services = [];
    for (var item in response.data) {
      services.add(ServiceModel.fromMap(item));
    }

    return services;
  }

  @override
  Future<List<ServiceOffer>> getOffers() async {
    const url = ApiEndPoint.SERVICES_OFFERS;

    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }

    final List<ServiceOffer> offers = [];
    for (var item in response.data) {
      offers.add(ServiceOffer.fromMap(item));
    }

    return offers;
  }
}
