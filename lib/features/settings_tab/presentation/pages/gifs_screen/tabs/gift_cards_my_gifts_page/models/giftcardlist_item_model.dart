
import 'package:masaj/core/utils/image_constant.dart';

/// This class is used in the [giftcardlist_item_widget] screen.
class GiftcardlistItemModel {
  GiftcardlistItemModel({
    this.imageClass,
    this.text1,
    this.text2,
    this.id,
  }) {
    imageClass = imageClass ?? ImageConstant.imgGroup1000003355;
    text1 = text1 ?? "Gift 10 OFF";
    text2 = text2 ?? "10 KWD";
    id = id ?? "";
  }

  String? imageClass;

  String? text1;

  String? text2;

  String? id;
}
