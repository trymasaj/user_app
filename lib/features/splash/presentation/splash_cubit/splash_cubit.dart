import 'dart:developer';

import 'package:masaj/core/service/device_security_service.dart';

import '../../../../core/service/notification_service.dart';
import '../../data/repositories/splash_repository_impl.dart';

import '../../../../core/abstract/base_cubit.dart';
import '../../../../core/exceptions/redundant_request_exception.dart';

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
      //await _notificationService.inti();
      await Future.delayed(const Duration(seconds: 4));
      emit(state.copyWith(
        status: SplashStateStatus.loaded,
        isFirstLaunch: isFirstLaunch,
        isLanguageSet: isLanguageSet,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: SplashStateStatus.error, errorMessage: e.toString()));
    }
  }
}
