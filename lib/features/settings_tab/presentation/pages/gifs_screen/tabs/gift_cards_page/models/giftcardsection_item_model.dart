
import 'package:masaj/core/utils/image_constant.dart';

/// This class is used in the [giftcardsection_item_widget] screen.
class GiftcardsectionItemModel {
  GiftcardsectionItemModel({
    this.text,
    this.imageClass,
    this.text1,
    this.text2,
    this.id,
  }) {
    text = text ?? "GIFT CARD";
    imageClass = imageClass ?? ImageConstant.imgEffects;
    text1 = text1 ?? "10";
    text2 = text2 ?? "KWD";
    id = id ?? "";
  }

  String? text;

  String? imageClass;

  String? text1;

  String? text2;

  String? id;
}
