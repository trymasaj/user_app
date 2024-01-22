// create timer cubit

part of 'resend_cubit.dart';

mixin ResendStateStatusHelper on ResendState {
  bool get isInitial => status == TimerStateStatus.initial;

  bool get isLoading => status == TimerStateStatus.loading;

  bool get isSuccess => status == TimerStateStatus.success;

  bool get isError => status == TimerStateStatus.error;
}

enum TimerStateStatus {
  initial,
  loading,
  success,
  error,
}

// TimerState
class ResendState extends Equatable {
  final int remainingTime;
  final String? errorMessage;
  final TimerStateStatus status;
  final bool isTimerRunning;
  final int start = 10;

  const ResendState({
    this.remainingTime = 10,
    this.errorMessage,
    this.status = TimerStateStatus.initial,
    this.isTimerRunning = false,
  });

  @override
  List<Object?> get props =>
      [remainingTime, errorMessage, status, isTimerRunning, start];

  ResendState copyWith({
    int? remainingTime,
    String? errorMessage,
    TimerStateStatus? status,
    bool? isTimerRunning,
    int? start,
  }) {
    return ResendState(
      remainingTime: remainingTime ?? this.remainingTime,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
    );
  }
}
