// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServiceState> {
  final ServiceRepository _serviceRepository;

  ServiceCubit(this._serviceRepository) : super(const ServiceState());
  void setServiceCategory(
      {ServiceCategory? selectedServiceCategory,
      required List<ServiceCategory> allServicesCategories}) {
    if (selectedServiceCategory != null) {
      allServicesCategories.sort((a, b) {
        if (a.id == selectedServiceCategory.id) {
          return -1;
        } else if (b.id == selectedServiceCategory.id) {
          return 1;
        } else {
          return 0;
        }
      });
    }
    emit(state.copyWith(
        selectedServiceCategory: selectedServiceCategory,
        allServiceCategories: allServicesCategories));
  }

  Future<void> setSelectedServiceCategory(
      ServiceCategory selectedServiceCategory) async {
    emit(state.copyWith(selectedServiceCategory: selectedServiceCategory));
    await loadServices();
  }

// set search keyword
  Future<void> setSearchKeyword(String searchKeyword) async {
    emit(state.copyWith(
        searchKeyword: searchKeyword, clearSearch: searchKeyword.isEmpty));
    await loadServices();
  }

  void setTherapistId(int id) {
    emit(state.copyWith(therapistId: id));
  }

  Future<void> loadServices({
    bool refresh = false,
  }) async {
    if (refresh) {
      emit(state.copyWith(status: ServiceStateStatus.isRefreshing));
    } else {
      emit(state.copyWith(status: ServiceStateStatus.loading));
    }
    try {
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: state.priceFrom,
          priceTo: state.priceTo,
          searchKeyword: state.searchKeyword,
          page: 1,
          therapistId: state.therapistId,
          pageSize: state.pageSize));
      emit(state.copyWith(
        status: ServiceStateStatus.loaded,
        services: services,
        page: 1,
        searchKeyword: state.searchKeyword,
        therapistId: state.therapistId,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: ServiceStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreServices() async {
    if (state.isLoadingMore) return;
    if (state.services?.data?.isEmpty ?? true) return;
    emit(state.copyWith(status: ServiceStateStatus.loadingMore));
    try {
      final oldServices = state.services;
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: state.priceFrom,
          priceTo: state.priceTo,
          // searchKeyword: state.searchKeyword,
          page: state.page! + 1,
          therapistId: state.therapistId,
          pageSize: state.pageSize));
      emit(state.copyWith(
          status: ServiceStateStatus.loaded,
          services: services.copyWith(data: [
            ...oldServices!.data ?? [],
            ...services.data ?? [],
          ]),
          page: state.page! + 1));
    } catch (e) {
      emit(state.copyWith(
          status: ServiceStateStatus.error, errorMessage: e.toString()));
    }
  }

  // set price range
  Future<void> setPriceRange(double? priceFrom, double? priceTo,
      double? maxPrice, double? minPrice) async {
    emit(state.copyWith(priceFrom: priceFrom, priceTo: priceTo));
    await loadServices();
  }

  // clear filter
  Future<void> clearFilter() async {
    emit(state.copyWith(priceFrom: null, priceTo: null, clearPrice: true));
    await loadServices();
  }
}
