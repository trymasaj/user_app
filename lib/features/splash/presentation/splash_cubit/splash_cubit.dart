import 'dart:developer';

import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/device/device_security_service.dart';
import 'package:masaj/core/data/device/notification_service.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/splash/data/repositories/splash_repository_impl.dart';

part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required SplashRepository splashRepository,
    required NotificationService notificationService,
    required DeviceSecurityService deviceSecurityService,
  })  : _notificationService = notificationService,
        _splashRepository = splashRepository,
        _deviceSecurityService = deviceSecurityService,
        super(const SplashState());

  final SplashRepository _splashRepository;
  final NotificationService _notificationService;
  final DeviceSecurityService _deviceSecurityService;

  Future<void> init() async {
    try {
      final isLanguageSet = await _splashRepository.isLanguageSet();
      final isFirstLaunch = await _splashRepository.isFirstLaunch();
      final isCountrySet = await _splashRepository.isCountrySet();
      //await _notificationService.inti();
      await Future.delayed(const Duration(seconds: 4));
      emit(state.copyWith(
        status: SplashStateStatus.loaded,
        isFirstLaunch: isFirstLaunch,
        isLanguageSet: isLanguageSet,
        isCountrySet: isCountrySet,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: SplashStateStatus.error, errorMessage: e.toString()));
    }
  }
}
