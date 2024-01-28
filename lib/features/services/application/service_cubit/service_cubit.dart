import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServcieState> {
  final ServiceRepository _serviceRepository;

  ServiceCubit(this._serviceRepository) : super(const ServcieState());

  Future<void> getServices(ServiceQueryModel serviceQueryModel) async {
    emit(state.copyWith(status: ServcieStateStatus.loading));
    try {
      final services = await _serviceRepository.getServices(serviceQueryModel);
      emit(state.copyWith(
          status: ServcieStateStatus.loaded, services: services));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieStateStatus.error, errorMessage: e.toString()));
    }
  }
}