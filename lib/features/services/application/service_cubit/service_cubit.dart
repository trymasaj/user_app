import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServcieState> {
  final ServiceRepository _serviceRepository;

  ServiceCubit(this._serviceRepository) : super(const ServcieState());
  void setServiceCategory(
      {required ServiceCategory selectedServiceCategory,
      required List<ServiceCategory> allServicesCategories}) {
    // sort allServicesCategories to make sure that the selectedServiceCategory is the first item
    allServicesCategories.sort((a, b) {
      if (a.id == selectedServiceCategory.id) {
        return -1;
      } else if (b.id == selectedServiceCategory.id) {
        return 1;
      } else {
        return 0;
      }
    });
    emit(state.copyWith(
        slectedServiceCategory: selectedServiceCategory,
        allServiceCategories: allServicesCategories));
  }

  void setSelectedServiceCategory(ServiceCategory selectedServiceCategory) {
    refresh();
    emit(state.copyWith(slectedServiceCategory: selectedServiceCategory));
    getServices();
  }

  void refresh() {
    emit(state.copyWith(
        status: ServcieStateStatus.initial,
        services: [],
        page: 1,
        pageSize: 10));
  }

  Future<void> getServices({
    double? priceFrom,
    double? priceTo,
  }) async {
    print('*' * 100);
    print(priceFrom);
    emit(state.copyWith(status: ServcieStateStatus.loading));
    try {
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: priceFrom,
          priceTo: priceTo,
          page: state.page,
          pageSize: state.pageSize));
      emit(state.copyWith(
          status: ServcieStateStatus.loaded, services: services));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieStateStatus.error, errorMessage: e.toString()));
    }
  }
}
