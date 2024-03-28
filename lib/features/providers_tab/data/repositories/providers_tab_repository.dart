import 'package:masaj/core/data/models/pagination_response.dart';
import 'package:masaj/features/providers_tab/data/datasources/providers_tab_remote_data_source.dart';
import 'package:masaj/features/providers_tab/data/models/avilable_therapist_model.dart';
import 'package:masaj/features/providers_tab/data/models/provider_query_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';

abstract class TherapistsRepository {
  Future<List<Therapist>> getRecommended();
  Future<PaginationResponse<Therapist>> getTherapistsByTabs(
      ProvideQueryModel provideQueryModel);
  Future<Therapist> getSingleTherapist(int id);
  Future<bool> favTherapist(int id, bool isFav);
  Future<List<AvailableTherapistModel>> getAvailableTherapists(
      {required DateTime bookingDate, required int pickTherapistType});
}

class TherapistsRepositoryImpl implements TherapistsRepository {
  final TherapistsDataSource _remoteDataSource;

  TherapistsRepositoryImpl({
    required TherapistsDataSource providers_tabRemoteDataSource,
  }) : _remoteDataSource = providers_tabRemoteDataSource;

  @override
  Future<bool> favTherapist(int id, bool isFav) async {
    return await _remoteDataSource.favTherapist(id, isFav);
  }

  @override
  Future<List<Therapist>> getRecommended() async {
    return await _remoteDataSource.getRecommended();
  }

  @override
  Future<Therapist> getSingleTherapist(int id) async {
    return await _remoteDataSource.getSingleTherapist(id);
  }

  @override
  Future<PaginationResponse<Therapist>> getTherapistsByTabs(
      ProvideQueryModel provideQueryModel) async {
    return await _remoteDataSource.getTherapistsByTabs(provideQueryModel);
  }

  @override
  Future<List<AvailableTherapistModel>> getAvailableTherapists(
      {required DateTime bookingDate, required int pickTherapistType}) async {
    return await _remoteDataSource.getAvailableTherapists(
        bookingDate: bookingDate, pickTherapistType: pickTherapistType);
  }
}
