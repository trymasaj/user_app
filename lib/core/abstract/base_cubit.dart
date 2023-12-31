import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) {
    debugPrint('init cubit $runtimeType');
  }
  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() {
    debugPrint('close cubit $runtimeType');
    return super.close();
  }
}
