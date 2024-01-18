
import 'package:masaj/core/presentation/constants/image_constant.dart';

/// This class is used in the [userprofile8_item_widget] screen.
class Userprofile8ItemModel {
  Userprofile8ItemModel({
    this.clockImage,
    this.fiveText,
    this.kwdText,
    this.freeKwdText,
    this.id,
  }) {
    clockImage = clockImage ?? ImageConstant.imgClock;
    fiveText = fiveText ?? '5';
    kwdText = kwdText ?? 'KWD';
    freeKwdText = freeKwdText ?? '+ Free 1 KWD';
    id = id ?? '';
  }

  String? clockImage;

  String? fiveText;

  String? kwdText;

  String? freeKwdText;

  String? id;
}
