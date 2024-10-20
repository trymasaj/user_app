import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';

abstract class BaseCubit<T> extends Cubit<T> {

  final AbsLogger logger = DI.find();

  BaseCubit(super.initialState) {
    logger.debug('init Type= [$runtimeType]');
  }

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() {
    logger.debug('close Type= [$runtimeType]');
    return super.close();
  }
}

