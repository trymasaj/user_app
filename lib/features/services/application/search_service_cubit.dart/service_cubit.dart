import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'service_state.dart';

class SearchServiceCubit extends BaseCubit<SearchServcieState> {
  final ServiceRepository _serviceRepository;

  SearchServiceCubit(this._serviceRepository)
      : super(const SearchServcieState()) {
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .listen((query) {
      getServices(query);
    });
  }

  void clear() {
    emit(
        state.copyWith(status: SearchServcieStateStatus.initial, services: []));
  }

  // void setServiceCategory(
  //     {required ServiceCategory selectedServiceCategory,
  //     required List<ServiceCategory> allServicesCategories}) {
  //   // sort allServicesCategories to make sure that the selectedServiceCategory is the first item
  //   allServicesCategories.sort((a, b) {
  //     if (a.id == selectedServiceCategory.id) {
  //       return -1;
  //     } else if (b.id == selectedServiceCategory.id) {
  //       return 1;
  //     } else {
  //       return 0;
  //     }
  //   });
  //   emit(state.copyWith(
  //       slectedServiceCategory: selectedServiceCategory,
  //       allServiceCategories: allServicesCategories));
  // }

  // void setSelectedServiceCategory(ServiceCategory selectedServiceCategory) {
  //   refresh();
  //   emit(state.copyWith(slectedServiceCategory: selectedServiceCategory));
  //   getServices();
  // }

  // void refresh() {
  //   emit(state.copyWith(
  //       status: SearchServcieStateStatus.initial,
  //       services: [],
  //       page: 1,
  //       pageSize: 10));
  // }
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  String get searchValue => _searchSubject.value;
  Stream<String> get searchStream => _searchSubject.stream;
  void setSearchValue(String value) {
    _searchSubject.add(value);
  }

  Future<void> getServices(String query) async {
    emit(state.copyWith(status: SearchServcieStateStatus.loading));
    try {
      final services = await _serviceRepository.getServices(ServiceQueryModel(
          searchKeyword: query, page: state.page, pageSize: state.pageSize));
      emit(state.copyWith(
          status: SearchServcieStateStatus.loaded, services: services));
    } catch (e) {
      emit(state.copyWith(
          status: SearchServcieStateStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _searchSubject.close();
    return super.close();
  }
}
