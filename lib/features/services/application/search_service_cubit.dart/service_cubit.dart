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
