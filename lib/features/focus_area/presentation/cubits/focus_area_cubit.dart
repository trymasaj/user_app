import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/enums/focus_area.dart';

part 'focus_area_state.dart';

class FocusAreaCubit extends BaseCubit<FocusAreaState> {
  FocusAreaCubit() : super(FocusAreaState());
  Map<FocusAreas, bool> focusPositions = {};

  void init() {
    emit(state.copyWith(status: FocusAreaStateStatus.initial));

    focusPositions.addAll({
      FocusAreas.Head: false,
      FocusAreas.Neck: false,
      FocusAreas.Shoulders: false,
      FocusAreas.Chest: false,
      FocusAreas.Abdomen: false,
      FocusAreas.Arms: false,
      FocusAreas.Legs: false,
      FocusAreas.Feet: false,
      FocusAreas.UpperBack: false,
      FocusAreas.LowerBack: false,
      FocusAreas.Spine: false,
      FocusAreas.Hips: false,
      FocusAreas.Buttocks: false,
      FocusAreas.Thighs: false,
      FocusAreas.Calves: false,
    });
    emit(state.copyWith(
      status: FocusAreaStateStatus.loaded,
      type: FocusAreaStateType.Front,
    ));
  }

  void setPosition(bool value, FocusAreas position) {
    emit(state.copyWith(status: FocusAreaStateStatus.loading));
    focusPositions[position] = value;

    emit(state.copyWith(
        positions: focusPositions, status: FocusAreaStateStatus.updated));
  }

  void resetPositions() {
    emit(state.copyWith(status: FocusAreaStateStatus.loading));

    focusPositions.forEach((key, value) {
      focusPositions[key] = false;
    });
    emit(state.copyWith(
        positions: focusPositions, status: FocusAreaStateStatus.updated));
  }

  void changeBody(FocusAreaStateType type) {
    emit(state.copyWith(status: FocusAreaStateStatus.loading));

    emit(state.copyWith(
      status: FocusAreaStateStatus.updated,
      type: type,
    ));
  }
}
