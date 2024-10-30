import 'package:masaj/core/app_text.dart';

enum FocusAreas {
  // Front
  Head,
  Neck,
  Shoulders,
  Chest,
  Abdomen,
  Arms,
  Legs,
  Feet,

  // Back
  UpperBack,
  LowerBack,
  Spine,
  Hips,
  Buttocks,
  Thighs,
  Calves,
}

enum BodySideEnum { Front, Back }

extension FocusAreaEnumExt on FocusAreas{
  String get name {
    switch (this){
    case FocusAreas.Head: return AppText.Head;
    case FocusAreas.Neck: return AppText.Neck;
    case FocusAreas.Shoulders: return AppText.Shoulders;
    case FocusAreas.Chest: return AppText.Chest;
    case FocusAreas.Abdomen: return AppText.Abdomen;
    case FocusAreas.Arms: return AppText.Arms;
    case FocusAreas.Legs: return AppText.Legs;
    case FocusAreas.Feet: return AppText.Feet;
    case FocusAreas.UpperBack: return AppText.upper_back;
    case FocusAreas.LowerBack: return AppText.lower_back;
    case FocusAreas.Spine: return AppText.spine;
    case FocusAreas.Hips: return AppText.hips;
    case FocusAreas.Buttocks: return AppText.buttocks;
    case FocusAreas.Thighs: return AppText.thighs;
    case FocusAreas.Calves: return AppText.calves;
    }
  }
}

extension BodySideEnumExt on BodySideEnum{
  String get name {
    switch (this) {
      case BodySideEnum.Front: return AppText.Front;
      case BodySideEnum.Back: return AppText.back;
    }
  }
}