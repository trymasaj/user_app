// ignore_for_file: no_leading_underscores_for_local_identifiers

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
        slectedServiceCategory: selectedServiceCategory,
        allServiceCategories: allServicesCategories));
  }

  void setSelectedServiceCategory(ServiceCategory selectedServiceCategory) {
    emit(state.copyWith(slectedServiceCategory: selectedServiceCategory));
    loadServices();
  }

// setsearch keyword
  void setSearchKeyword(String searchKeyword) {
    emit(state.copyWith(
        searchKeyword: searchKeyword, clearSearch: searchKeyword.isEmpty));
    loadServices();
  }

  Future<void> loadServices({
    bool refresh = false,
  }) async {
    if (refresh) {
      emit(state.copyWith(status: ServcieStateStatus.isRefreshing));
    } else {
      emit(state.copyWith(status: ServcieStateStatus.loading));
    }
    try {
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: state.priceFrom,
          priceTo: state.priceTo,
          searchKeyword: state.searchKeyword,
          page: 1,
          pageSize: state.pageSize));
      emit(state.copyWith(
        status: ServcieStateStatus.loaded,
        services: services,
        page: 1,
        searchKeyword: state.searchKeyword,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreServices() async {
    if (state.isLoadingMore) return;
    if (state.services?.data?.isEmpty ?? true) return;
    emit(state.copyWith(status: ServcieStateStatus.loadingMore));
    try {
      final oldServices = state.services;
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: state.priceFrom,
          priceTo: state.priceTo,
          // searchKeyword: state.searchKeyword,
          page: state.page! + 1,
          pageSize: state.pageSize));
      emit(state.copyWith(
          status: ServcieStateStatus.loaded,
          services: services.copyWith(data: [
            ...oldServices!.data ?? [],
            ...services.data ?? [],
          ]),
          page: state.page! + 1));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieStateStatus.error, errorMessage: e.toString()));
    }
  }

  // set price range
  void setPriceRange(
      double? priceFrom, double? priceTo, double? maxPrice, double? minPrice) {
    emit(state.copyWith(priceFrom: priceFrom, priceTo: priceTo));
    loadServices();
  }

  // clear filter
  void clearFilter() {
    emit(state.copyWith(priceFrom: null, priceTo: null, clearPrice: true));
    loadServices();
  }

  // Future<void> getServices(
  //     {double? priceFrom,
  //     double? priceTo,
  //     String? searchKeyword,
  //     double? maxPrice,
  //     double? minPrice,
  //     bool loadMore = false,
  //     bool? clearPrice}) async {
  //   if (state.isLoadingMore) return;
  //   final oldServices = state.services;

  //   if ((state.hasReachedMax ?? false)) return;
  //   final page = loadMore ? (state.page ?? 1) + 1 : 1;

  //   emit(state.copyWith(
  //       status: loadMore
  //           ? ServcieStateStatus.loadingMore
  //           : ServcieStateStatus.loading));
  //   try {
  //     final services = await _serviceRepository.getServices(ServiceQueryModel(
  //         categoryId: state.slectedServiceCategory!.id,
  //         priceFrom: priceFrom,
  //         priceTo: priceTo,
  //         page: page,
  //         searchKeyword: searchKeyword,
  //         pageSize: state.pageSize));

  //     // iterate it to be than 10
  //     await Future.delayed(const Duration(seconds: 2), () {
  //       if ((oldServices ?? []).isNotEmpty) {
  //         services.addAll(List.generate(
  //             10 - services.length, (index) => (oldServices ?? []).first));
  //       } else {
  //         services.addAll(
  //             List.generate(10 - services.length, (index) => services.first));
  //       }
  //     });

  //     final hasReachedMax = services.length < (state.pageSize ?? 10);

  //     emit(state.copyWith(
  //         status: ServcieStateStatus.loaded,
  //         services:
  //             loadMore ? [...(state.services ?? []), ...services] : services,
  //         maxPrice: maxPrice ?? state.maxPrice,
  //         page: page,
  //         priceFrom: priceFrom,
  //         minPrice: minPrice ?? state.minPrice,
  //         clearPrice: clearPrice ?? false,
  //         priceTo: priceTo,
  //         hasReachedMax: hasReachedMax));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         status: ServcieStateStatus.error, errorMessage: e.toString()));
  //   }
  // }
}
