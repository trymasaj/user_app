// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServcieState> {
  final ServiceRepository _serviceRepository;
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  String get searchValue => _searchSubject.value;
  Stream<String> get searchStream => _searchSubject.stream;
  void setSearchValue(String value) {
    _searchSubject.add(value);
  }

  ServiceCubit(this._serviceRepository) : super(const ServcieState()) {
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) {
          
      getServices(
          searchKeyword: query,
          refresh: true,
          priceFrom: state.priceFrom,
          priceTo: state.priceTo);
    });
  }
  void setServiceCategory(
      {ServiceCategory? selectedServiceCategory,
      required List<ServiceCategory> allServicesCategories}) {
    // sort allServicesCategories to make sure that the selectedServiceCategory is the first item
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
    refresh();
    emit(state.copyWith(slectedServiceCategory: selectedServiceCategory));
    getServices(refresh: true);
  }

  void refresh() {
    emit(state.copyWith(
        status: ServcieStateStatus.initial,
        services: [],
        page: 1,
        pageSize: 10));
  }

  Future<void> getServices(
      {double? priceFrom,
      double? priceTo,
      String? searchKeyword,
      double? maxPrice,
      double? minPrice,
      bool refresh = false,
      bool loadMore = false,
      bool? clearPrice}) async {
    if (refresh) {
      emit(state.copyWith(page: 1, services: [], hasReachedMax: false));
    }

    if ((state.hasReachedMax ?? false)) return;
    final page = loadMore ? (state.page ?? 1) + 1 : 1;

    emit(state.copyWith(status: ServcieStateStatus.loading));
    try {
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          categoryId: state.slectedServiceCategory!.id,
          priceFrom: priceFrom,
          priceTo: priceTo,
          page: page,
          searchKeyword: searchKeyword,
          pageSize: state.pageSize));

      final hasReachedMax = services.length < (state.pageSize ?? 10);

      emit(state.copyWith(
          status: ServcieStateStatus.loaded,
          services: services,
          maxPrice: maxPrice ?? state.maxPrice,
          page: page,
          priceFrom: priceFrom,
          minPrice: minPrice ?? state.minPrice,
          clearPrice: clearPrice ?? false,
          priceTo: priceTo,
          hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieStateStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _searchSubject.close();
    return super.close();
  }
}
