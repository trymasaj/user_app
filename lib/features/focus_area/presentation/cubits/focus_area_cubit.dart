import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/enums/focus_area.dart';

part 'focus_area_state.dart';

class FocusAreaCubit extends BaseCubit<FocusAreaState> {
  FocusAreaCubit() : super(const FocusAreaState());
  Map<FocusAreas, bool> focusPositions = {};

  void init() {
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
  }

  void setPosition(bool value, FocusAreas position) {
    focusPositions[position] = value;
    
    emit(state.copyWith(positions: focusPositions));

  }

  void changeBody(FocusAreaStateType type) {
    emit(state.copyWith(type: type));
  }
}
