import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

part 'service_details_state.dart';

// cubit

class ServiceDetailsCubit extends BaseCubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(const ServiceDetailsState());

  Future<void> getServiceDetails(ServiceModel service) async {
    emit(state.copyWith(status: ServiceDetailsStateStatus.loading));
    try {
      emit(state.copyWith(
          status: ServiceDetailsStateStatus.loaded, service: service));
    } catch (e) {
      emit(state.copyWith(
          status: ServiceDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
