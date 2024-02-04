// create timer cubit

import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/auth/data/repositories/auth_repository.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';

part 'resend_state.dart';

class ResendCubit extends Cubit<ResendState> {
  ResendCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const ResendState()) {
    startTimer();
  }

  late Timer timer;

  final AuthRepository _authRepository;
  startTimer() {
    emit(
      state.copyWith(isTimerRunning: true, remainingTime: state.start),
    );
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime == 0) {
        emit(state.copyWith(isTimerRunning: false));
        timer.cancel();
      } else {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      }
    });
  }

  @override
  close() async {
    timer.cancel();
    super.close();
  }

  Future<void> resendOtp(User user) async {
    emit(state.copyWith(status: TimerStateStatus.loading));

    try {
      await _authRepository.resendOtp(
        user,
      );
      emit(state.copyWith(status: TimerStateStatus.success));
      startTimer();
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
        status: TimerStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
