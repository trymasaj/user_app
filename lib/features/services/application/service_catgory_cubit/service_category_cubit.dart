import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
part 'service_category_state.dart';

class ServiceCategoryCubit extends BaseCubit<ServiceCategoryState> {
  final ServiceRepository _serviceRepository;

  ServiceCategoryCubit(this._serviceRepository)
      : super(const ServiceCategoryState());

  Future<void> getServiceCategories() async {
    emit(state.copyWith(status: ServiceCategoryStateStatus.loading));
    try {
      final serviceCategories = await _serviceRepository.getServiceCategories();
      emit(state.copyWith(
          status: ServiceCategoryStateStatus.loaded,
          serviceCategories: serviceCategories));
    } catch (e) {
      emit(state.copyWith(
          status: ServiceCategoryStateStatus.error,
          errorMessage: e.toString()));
    }
  }
}
