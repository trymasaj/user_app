import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';

part 'service_details_state.dart';

// cubit

class ServiceDetailsCubit extends BaseCubit<ServiceDetailsState> {
  ServiceDetailsCubit(this._serviceRepository)
      : super(const ServiceDetailsState());
  final ServiceRepository _serviceRepository;

  Future<void> getServiceDetails(int id) async {
    emit(state.copyWith(
      status: ServiceDetailsStateStatus.loading,
    ));
    try {
      final service = await _serviceRepository.getSingleService(id);
      emit(state.copyWith(
        status: ServiceDetailsStateStatus.loaded,
        service: service,
      ));
      // AdjustTracker.trackViewProduct(service.title ?? '');
    } catch (e) {
      emit(state.copyWith(
        status: ServiceDetailsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
