import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';
import 'package:masaj/features/home/data/models/banner.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_offer.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';

part 'home_page_cubit_state.dart';

class HomePageCubit extends BaseCubit<HomePageState> {
  final HomeRepository _homeRepository;
  final ServiceRepository _serviceRepository;
  final BookingRepository _bookingRepository;

  HomePageCubit(
      this._homeRepository, this._serviceRepository, this._bookingRepository)
      : super(HomePageState.initial());

  Future<void> refresh() async => init();

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading));
    await Future.wait([
      getBanners(),
      getRecommendedServices(),
      getOffers(),
      getRepeatedSessions(),
    ]);
    emit(state.copyWith(status: Status.loaded));
  }

  Future<void> getBanners() async {
    try {
      final banners = await _homeRepository.getBanners();
      emit(state.copyWith(banners: banners));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getRecommendedServices() async {
    try {
      final services = await _serviceRepository.getRecommended();
      emit(state.copyWith(recommendedServices: services));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getOffers() async {
    try {
      final offers = await _serviceRepository.getOffers();
      emit(state.copyWith(offers: offers));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getRepeatedSessions() async {
    try {
      const query = BookingQueryModel(
        status: BookingQueryStatus.completed,
        page: 1,
        pageSize: 5,
      );
      final sessions = await _bookingRepository.getBookingList(query);
      emit(state.copyWith(repeatedSessions: sessions.data));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
