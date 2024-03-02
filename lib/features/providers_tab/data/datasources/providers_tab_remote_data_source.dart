import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/data/models/pagination_response.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/providers_tab/data/models/provider_query_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';

abstract class TherapistsDataSource {
  Future<List<Therapist>> getRecommended();
  Future<PaginationResponse<Therapist>> getTherapistsByTabs(
    ProvideQueryModel provideQueryModel,
  );
  // therapist details
  Future<Therapist> getSingleTherapist(int id);
  Future<bool> favTherapist(int id, bool isFav);
}

class TherapistsDataSourceImpl implements TherapistsDataSource {
  final NetworkService _networkService;

  TherapistsDataSourceImpl(this._networkService);

  @override
  Future<List<Therapist>> getRecommended() async {
    const url = ApiEndPoint.RECOMMENDED_THERAPISTS;
    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }
    final List<Therapist> therapists = [];
    for (var item in response.data) {
      therapists.add(Therapist.fromMap(item));
    }
    return therapists;
  }

  @override
  Future<PaginationResponse<Therapist>> getTherapistsByTabs(
      ProvideQueryModel provideQueryModel) async {
    const url = ApiEndPoint.Therapists;
    final response = await _networkService.get(
      url,
      queryParameters: provideQueryModel.toMap(),
    );

    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }
    return PaginationResponse.fromMap(response.data,
        mapperFunc: Therapist.fromMap);
  }

  @override
  Future<Therapist> getSingleTherapist(int id) async {
    final url = '${ApiEndPoint.Therapists}/$id';
    final response = await _networkService.get(url);
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }
    final res = Therapist.fromMap(response.data);

    return res;
  }

  @override
  Future<bool> favTherapist(int id, bool isFav) async {
    final url = '${ApiEndPoint.FAV_THERAPISTS}/$id';
    final response = await _networkService.post(url, data: {'status': isFav});
    if (![201, 200].contains(response.statusCode)) {
      throw RequestException.fromStatusCode(
          statusCode: response.statusCode!, response: response.data);
    }
    return isFav;
  }
}
