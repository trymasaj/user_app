import 'package:masaj/core/application/controllers/base_cubit.dart';

part 'focus_area_state.dart';

class FocusAreaCubit extends BaseCubit<FocusAreaState> {
  FocusAreaCubit() : super(const FocusAreaState());

  void changeBody(FocusAreaStateType type) {
    emit(state.copyWith(type: type));
  }
}
