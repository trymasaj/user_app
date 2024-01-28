import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
part 'service_category_state.dart';

class ServiceCategoryCubit extends BaseCubit<ServcieCategoryState> {
  final ServiceRepository _serviceRepository;

  ServiceCategoryCubit(this._serviceRepository)
      : super(const ServcieCategoryState());

  Future<void> getServiceCategories() async {
    print('________________');
    emit(state.copyWith(status: ServcieCategoryStateStatus.loading));
    try {
      final serviceCategories = await _serviceRepository.getServiceCategories();
      print(serviceCategories);
      emit(state.copyWith(
          status: ServcieCategoryStateStatus.loaded,
          serviceCategories: serviceCategories));
    } catch (e) {
      emit(state.copyWith(
          status: ServcieCategoryStateStatus.error,
          errorMessage: e.toString()));
    }
  }
}
